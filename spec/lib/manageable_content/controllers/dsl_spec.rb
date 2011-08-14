require 'spec_helper'

describe "The Controller Dsl" do

  context "class methods" do
    context "manageable_content_for" do
      it "should configure the content keys for the HomeController" do
        HomeController.manageable_content_for.should == [:body, :side]
      end
      it "should configure the content keys for the ContactController" do
        ContactController.manageable_content_for.should == [:body, :message]
      end
    end

    context "manageable_layout_content_for" do
      it "should configure the layout content keys for the ApplicationController" do
        ApplicationController.manageable_layout_content_for.should == [:footer_copyright, :footer_contact]
      end
    end
  end

  context "instance methods" do
    context "for controller instances with configured pages" do
      before :each do
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
      end

      context "manageable_content_for helper" do
        context "HomeController" do
          it "should retrieve the correct content for :body" do
            @home_controller.manageable_content_for(:body).should == @home_body_content.content
          end
          it "should retrieve the correct content for :side" do
            @home_controller.manageable_content_for(:side).should == @home_side_content.content
          end
        end

        context "ContactController" do
          it "should retrieve the correct content for :body" do
            @contact_controller.manageable_content_for(:body).should == @contact_body_content.content
          end
          it "should retrieve the correct content for :message" do
            @contact_controller.manageable_content_for(:message).should == @contact_message_content.content
          end
        end
      end
    end
  end
end