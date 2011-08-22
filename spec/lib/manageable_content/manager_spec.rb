require 'spec_helper'

describe ManageableContent::Manager do

  context "class methods" do

    context "eligible_controllers" do
      it "should list the eligible controllers" do
        ManageableContent::Manager.eligible_controllers.should ==
          [ApplicationController, ContactController, HomeController]
      end
    end

    context "generate!" do
      before :each do
        ManageableContent::Manager.generate!
      end

      context "generated pages" do
        context "Layout" do
          context "application" do
            it "should have generated contents for each configured locale" do
              ManageableContent::Engine.config.locales.each do |locale|
                page = ManageableContent::Manager.page('application', locale).first

                page.key.should    == 'application'
                page.locale.should == locale.to_s
                page.page_contents.size.should == 4
                page.page_content(:title).should_not be_nil
                page.page_content(:keywords).should_not be_nil
                page.page_content(:footer_copyright).should_not be_nil
                page.page_content(:footer_contact).should_not   be_nil
              end
            end
          end

          context "blog" do
            it "should have generated contents for each configured locale" do
              ManageableContent::Engine.config.locales.each do |locale|
                page = ManageableContent::Manager.page('blog', locale).first

                page.key.should    == 'blog'
                page.locale.should == locale.to_s
                page.page_contents.size.should == 1
                page.page_content(:blog_title).should_not be_nil
              end
            end
          end
        end

        context "HomeController" do
          it "should have generated contents for each configured locale" do
            controller_path = HomeController.controller_path

            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Manager.page(controller_path, locale).first

              page.key.should    == controller_path
              page.locale.should == locale.to_s
              page.page_contents.size.should == 4
              page.page_content(:title).should_not    be_nil
              page.page_content(:keywords).should_not be_nil
              page.page_content(:body).should_not     be_nil
              page.page_content(:side).should_not     be_nil
            end
          end
        end

        context "ContactController" do
          it "should have generated contents for each configured locale" do
            controller_path = ContactController.controller_path

            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Manager.page(controller_path, locale).first

              page.key.should    == controller_path
              page.locale.should == locale.to_s
              page.page_contents.size.should == 4
              page.page_content(:title).should_not    be_nil
              page.page_content(:keywords).should_not be_nil
              page.page_content(:body).should_not     be_nil
              page.page_content(:message).should_not  be_nil
            end
          end
        end

        context "Blog::HomeController" do
          it "should NOT have generated contents for each configured locale" do
            controller_path = Blog::HomeController.controller_path

            ManageableContent::Engine.config.locales.each do |locale|
              ManageableContent::Manager.page(controller_path, locale).first.should be_nil
            end
          end
        end
      end

      context "pages" do
        before :each do
          #adding a mock page that should be non eligible
          create :page
        end

        it "should list the eligible pages" do
          ManageableContent::Manager.pages.should ==
            [ApplicationController, ContactController, HomeController].map do |controller_class|
              ManageableContent::Engine.config.locales.map do |locale|
                ManageableContent::Manager.page(controller_class.controller_path, locale).first
              end
            end.flatten
        end

        it "should list the eligible contents" do
          ManageableContent::Manager.eligible_contents(HomeController.controller_path).should ==
            {:title => :string, :keywords => :text, :body => :text, :side => :text}
        end
      end

      context "page" do
        it "should retrieve pages correctly" do
          [ApplicationController, ContactController, HomeController].each do |controller_class|
            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Manager
                      .page(controller_class.controller_path, locale).first

              page.key.should    == controller_class.controller_path
              page.locale.should == locale.to_s
            end
          end
        end
      end
    end
  end
end