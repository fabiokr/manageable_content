require 'spec_helper'

describe ManageableContent::Manager do

  context "class methods" do

    context "eligible_controllers" do
      it "should list the eligible controllers" do
        ManageableContent::Manager.eligible_controllers.should ==
          [ApplicationController, ContactController, HomeController]
      end
    end

    context "eligible_custom" do
      it "should list the eligible custom pages" do
        ManageableContent::Manager.eligible_custom.should ==
          ["static/page1", "static/page2"]
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
                page.page_content(:title).short.should            be_true
                page.page_content(:keywords).short.should         be_false
                page.page_content(:footer_copyright).short.should be_false
                page.page_content(:footer_contact).short.should   be_true
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
                page.page_content(:blog_title).short.should be_false
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
              page.page_content(:title).short.should    be_true
              page.page_content(:keywords).short.should be_false
              page.page_content(:body).short.should     be_false
              page.page_content(:side).short.should     be_false
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
              page.page_content(:title).short.should    be_true
              page.page_content(:keywords).short.should be_false
              page.page_content(:body).short.should     be_false
              page.page_content(:message).short.should  be_false
            end
          end
        end

        context "Custom Pages" do
          it "should have generated contents for each configured locale" do
            controller_path = ContactController.controller_path

            ManageableContent::Engine.config.locales.each do |locale|
              # Page1
              page = ManageableContent::Manager.page("static/page1", locale).first
              page.key.should    == "static/page1"
              page.locale.should == locale.to_s
              page.page_contents.size.should == 1
              page.page_content(:body).short.should be_false

              # Page1=2
              page = ManageableContent::Manager.page("static/page2", locale).first
              page.key.should    == "static/page2"
              page.locale.should == locale.to_s
              page.page_contents.size.should == 2
              page.page_content(:body).short.should be_false
              page.page_content(:footer).short.should be_true
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
            ([ApplicationController, ContactController, HomeController].map do |controller_class|
                ManageableContent::Engine.config.locales.map do |locale|
                  ManageableContent::Manager.page(controller_class.controller_path, locale).first
                end
              end.flatten + ["static/page1", "static/page2"].map do |custom_page_key|
                ManageableContent::Engine.config.locales.map do |locale|
                  ManageableContent::Manager.page(custom_page_key, locale).first
                end
              end.flatten)
        end

        it "should list the eligible contents" do
          ManageableContent::Manager.eligible_contents(HomeController.controller_path).should ==
            {:title => :string, :keywords => :text, :body => :text, :side => :text}

          ManageableContent::Manager.eligible_contents("static/page1").should ==
            {:body => :text}

          ManageableContent::Manager.eligible_contents("static/page2").should ==
            {:body => :text, :footer => :string}
        end
      end

      context "page" do
        it "should retrieve pages correctly" do
          [ApplicationController, ContactController, HomeController].each do |controller_class|
            ManageableContent::Engine.config.locales.each do |locale|
              page = ManageableContent::Manager.page(controller_class.controller_path, locale).first

              page.key.should    == controller_class.controller_path
              page.locale.should == locale.to_s
            end
          end
        end
      end
    end
  end
end