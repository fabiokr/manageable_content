require 'spec_helper'

describe ManageableContent::Generator do

  context "class methods" do

    context "generate!" do
      before :each do
        ManageableContent::Generator.generate!
      end

      context "Layout" do
        context "application" do
          it "should have generated contents for each configured locale" do
            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Page.for_key('application', locale).first

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

        context "blog" do
          it "should have generated contents for each configured locale" do
            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Page.for_key('blog', locale).first

              page.key.should    == 'blog'
              page.locale.should == locale.to_s
              page.page_contents.size.should == 1
              page.page_content_for_key(:blog_title).should_not be_nil
            end
          end
        end
      end

      context "HomeController" do
        it "should have generated contents for each configured locale" do
          controller_path = HomeController.controller_path

          ManageableContent::Engine.config.locales.each do |locale|
            page = ManageableContent::Page.for_key(controller_path, locale).first

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
            page = ManageableContent::Page.for_key(controller_path, locale).first

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
        it "should NOT have generated contents for each configured locale" do
          controller_path = Blog::HomeController.controller_path

          ManageableContent::Engine.config.locales.each do |locale|
            ManageableContent::Page.for_key(controller_path, locale).first.should be_nil
          end
        end
      end
    end

  end

end