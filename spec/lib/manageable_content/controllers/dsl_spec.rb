require 'spec_helper'

describe "The Controller Dsl" do

  context "class methods" do
    context "manageable_ignore_controller_namespaces" do
      it "should configure the Controllers namespaces that will be ignored" do
        ManageableContent::Controllers::Dsl.manageable_ignore_controller_namespace_keys.should == [:admin]
      end
    end

    context "manageable_layout_content_for" do
      it "should configure the layout content keys for layout" do
        ManageableContent::Controllers::Dsl.manageable_layout_content_keys['application'].should == 
          [:footer_copyright, :footer_contact]

        ManageableContent::Controllers::Dsl.manageable_layout_content_keys['register'].should == 
          [:register_text]
      end
    end

    context "manageable_default_content_for" do
      it "should configure the default content keys for all Controllers" do
        ManageableContent::Controllers::Dsl.manageable_default_content_keys.should == [:title, :keywords]
      end
    end

    context "manageable_content_for" do
      it "should configure the content keys for the HomeController" do
        HomeController.manageable_content_keys.should == [:body, :side]
      end
      it "should configure the content keys for the ContactController" do
        ContactController.manageable_content_keys.should == [:body, :message]
      end
    end
  end

  context "instance methods" do
    context "for controller instances with configured pages" do
      before :each do
        # Application Layout Contents
        @application_layout_page        = ManageableContent::Page.new
        @application_layout_page.key    = 'application'
        @application_layout_page.locale = I18n.locale
        @application_layout_page.save!

        @application_layout_footer_copyright_content         = @application_layout_page.page_contents.build
        @application_layout_footer_copyright_content.key     = "footer_copyright"
        @application_layout_footer_copyright_content.content = "The footer copyright content"
        @application_layout_footer_copyright_content.save!

        @application_layout_footer_contact_content         = @application_layout_page.page_contents.build
        @application_layout_footer_contact_content.key     = "footer_contact"
        @application_layout_footer_contact_content.content = "The footer contact content"
        @application_layout_footer_contact_content.save!

        # Register Layout Contents
        @register_layout_page        = ManageableContent::Page.new
        @register_layout_page.key    = 'register'
        @register_layout_page.locale = I18n.locale
        @register_layout_page.save!

        @register_layout_text_content         = @register_layout_page.page_contents.build
        @register_layout_text_content.key     = "register_text"
        @register_layout_text_content.content = "The register text content"
        @register_layout_text_content.save!

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
        context "with default application layout" do
          context "HomeController" do
            it "should retrieve the correct content for :body" do
              @home_controller.manageable_content_for(:body).should == @home_body_content.content
            end
            it "should retrieve the correct content for :side" do
              @home_controller.manageable_content_for(:side).should == @home_side_content.content
            end
            it "should retrieve the correct content for :footer_copyright" do
              @home_controller.manageable_content_for(:footer_copyright).should == 
                @application_layout_footer_copyright_content.content
            end
            it "should retrieve the correct content for :footer_contact" do
              @home_controller.manageable_content_for(:footer_contact).should == 
                @application_layout_footer_contact_content.content
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
              @contact_controller.manageable_content_for(:footer_copyright).should ==
                @application_layout_footer_copyright_content.content
            end
            it "should retrieve the correct content for :footer_contact" do
              @contact_controller.manageable_content_for(:footer_contact).should == 
                @application_layout_footer_contact_content.content
            end
          end
        end

        context "with custom register layout" do
          before :each do
            HomeController.layout     'register'
            ContactController.layout  'register'
          end

          context "HomeController" do
            it "should retrieve the correct content for :body" do
              @home_controller.manageable_content_for(:body).should == @home_body_content.content
            end
            it "should retrieve the correct content for :side" do
              @home_controller.manageable_content_for(:side).should == @home_side_content.content
            end
            it "should retrieve the correct content for :register_text" do
              @home_controller.manageable_content_for(:register_text).should == 
                @register_layout_text_content.content
            end
          end

          context "ContactController" do
            it "should retrieve the correct content for :body" do
              @contact_controller.manageable_content_for(:body).should == @contact_body_content.content
            end
            it "should retrieve the correct content for :message" do
              @contact_controller.manageable_content_for(:message).should == @contact_message_content.content
            end
            it "should retrieve the correct content for :register_text" do
              @home_controller.manageable_content_for(:register_text).should == 
                @register_layout_text_content.content
            end
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