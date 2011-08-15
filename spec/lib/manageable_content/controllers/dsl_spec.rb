require 'spec_helper'

describe "The Controller Dsl" do

  context "class methods" do
    context "manageable_layout_content_for" do
      it "should configure the layout content keys for the ApplicationController" do
        ManageableContent::Controllers::Dsl.manageable_layout_content_keys.should == [:footer_copyright, :footer_contact]
      end
    end

    context "manageable_default_content_for" do
      it "should configure the default content keys for all Controllers" do
        ManageableContent::Controllers::Dsl.manageable_default_content_keys.should == [:title, :keywords]
      end
    end

    context "manageable_content_for" do
      it "should configure the content keys for the HomeController including defaults" do
        HomeController.manageable_content_for.should == [:title, :keywords, :body, :side]
      end
      it "should configure the content keys for the ContactController including defaults" do
        ContactController.manageable_content_for.should == [:title, :keywords, :body, :message]
      end
    end
  end

  context "instance methods" do
    context "for controller instances with configured pages" do
      before :each do
        # Layout Contents
        @layout_page        = ManageableContent::Page.new
        @layout_page.key    = nil
        @layout_page.locale = I18n.locale
        @layout_page.save!

        @layout_footer_copyright_content         = @layout_page.page_contents.build
        @layout_footer_copyright_content.key     = "footer_copyright"
        @layout_footer_copyright_content.content = "The footer copyright content"
        @layout_footer_copyright_content.save!

        @layout_footer_contact_content         = @layout_page.page_contents.build
        @layout_footer_contact_content.key     = "footer_contact"
        @layout_footer_contact_content.content = "The footer contact content"
        @layout_footer_contact_content.save!

        # HomeController
        @home_controller = HomeController.new

        @home_page        = ManageableContent::Page.new
        @home_page.key    = @home_controller.controller_path
        @home_page.locale = I18n.locale
        @home_page.save!

        @home_body_content         = @home_page.page_contents.build
        @home_body_content.key     = "body"
        @home_body_content.content = "The home body content"
        @home_body_content.save!

        @home_side_content         = @home_page.page_contents.build
        @home_side_content.key     = "side"
        @home_side_content.content = "The home side content"
        @home_side_content.save!

        # ContactController
        @contact_controller = ContactController.new

        @contact_page        = ManageableContent::Page.new
        @contact_page.key    = @contact_controller.controller_path
        @contact_page.locale = I18n.locale
        @contact_page.save!

        @contact_body_content         = @contact_page.page_contents.build
        @contact_body_content.key     = "body"
        @contact_body_content.content = "The contact body content"
        @contact_body_content.save!

        @contact_message_content         = @contact_page.page_contents.build
        @contact_message_content.key     = "message"
        @contact_message_content.content = "The side content"
        @contact_message_content.save!

        # Blogs::HomeController
        @blogs_home_controller = Blogs::HomeController.new
      end

      context "manageable_content_for helper" do
        context "HomeController" do
          it "should retrieve the correct content for :body" do
            @home_controller.manageable_content_for(:body).should == @home_body_content.content
          end
          it "should retrieve the correct content for :side" do
            @home_controller.manageable_content_for(:side).should == @home_side_content.content
          end
          it "should retrieve the correct content for :footer_copyright" do
            @home_controller.manageable_content_for(:footer_copyright).should == @layout_footer_copyright_content.content
          end
          it "should retrieve the correct content for :footer_contact" do
            @home_controller.manageable_content_for(:footer_contact).should == @layout_footer_contact_content.content
          end
        end

        context "ContactController" do
          it "should retrieve the correct content for :body" do
            @contact_controller.manageable_content_for(:body).should == @contact_body_content.content
          end
          it "should retrieve the correct content for :message" do
            @contact_controller.manageable_content_for(:message).should == @contact_message_content.content
          end
          it "should retrieve the correct content for :footer_copyright" do
            @contact_controller.manageable_content_for(:footer_copyright).should == @layout_footer_copyright_content.content
          end
          it "should retrieve the correct content for :footer_contact" do
            @contact_controller.manageable_content_for(:footer_contact).should == @layout_footer_contact_content.content
          end
        end

        context "BlogController" do
          it "should retrieve nil for a non existent page content" do
            @blogs_home_controller.manageable_content_for(:non_existent).should be_nil
          end
        end
      end
    end
  end
end