require 'spec_helper'

describe ManageableContent::Controllers::Generator do

  context "class methods" do

    context "generate!" do
      before :each do
        ManageableContent::Controllers::Generator.generate!
      end

      context "Layout" do
        context "application" do
          it "should have generated contents for each configured locale" do
            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Page.for_key('application', locale)

              page.key.should    == 'application'
              page.locale.should == locale.to_s
              page.page_contents.size.should == 4
              page.page_content_for_key(:title).should_not be_nil
              page.page_content_for_key(:keywords).should_not be_nil
              page.page_content_for_key(:footer_copyright).should_not be_nil
              page.page_content_for_key(:footer_contact).should_not   be_nil
            end
          end
        end

        context "blog/application" do
          it "should have generated contents for each configured locale" do
            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Page.for_key('blog/application', locale)

              page.key.should    == 'blog/application'
              page.locale.should == locale.to_s
              page.page_contents.size.should == 3
              page.page_content_for_key(:title).should_not be_nil
              page.page_content_for_key(:keywords).should_not be_nil
              page.page_content_for_key(:blog_title).should_not be_nil
            end
          end
        end
      end

      context "HomeController" do
        it "should have generated contents for each configured locale" do
          controller_path = HomeController.controller_path

          ManageableContent::Engine.config.locales.each do |locale|
            page = ManageableContent::Page.for_key(controller_path, locale)

            page.key.should    == controller_path
            page.locale.should == locale.to_s
            page.page_contents.size.should == 4
            page.page_content_for_key(:title).should_not    be_nil
            page.page_content_for_key(:keywords).should_not be_nil
            page.page_content_for_key(:body).should_not     be_nil
            page.page_content_for_key(:side).should_not     be_nil
          end
        end
      end

      context "ContactController" do
        it "should have generated contents for each configured locale" do
          controller_path = ContactController.controller_path

          ManageableContent::Engine.config.locales.each do |locale|
            page = ManageableContent::Page.for_key(controller_path, locale)

            page.key.should    == controller_path
            page.locale.should == locale.to_s
            page.page_contents.size.should == 4
            page.page_content_for_key(:title).should_not    be_nil
            page.page_content_for_key(:keywords).should_not be_nil
            page.page_content_for_key(:body).should_not     be_nil
            page.page_content_for_key(:message).should_not  be_nil
          end
        end
      end

      context "Blog::HomeController" do
        it "should have generated contents for each configured locale" do
          controller_path = Blog::HomeController.controller_path

          ManageableContent::Engine.config.locales.each do |locale|
            page = ManageableContent::Page.for_key(controller_path, locale)

            page.key.should    == controller_path
            page.locale.should == locale.to_s
            page.page_contents.size.should == 2
            page.page_content_for_key(:title).should_not    be_nil
            page.page_content_for_key(:keywords).should_not be_nil
          end
        end

        context "ignored namespaces" do
          context "Admin::HomeController" do
            it "should NOT have generated contents for each configured locale" do
              controller_path = Admin::HomeController.controller_path

              ManageableContent::Engine.config.locales.each do |locale|
                ManageableContent::Page.for_key(controller_path, locale).should be_nil
              end
            end
          end
        end
      end
    end

  end

end