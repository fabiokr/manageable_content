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

        ManageableContent::Controllers::Dsl.manageable_layout_content_keys['blog/application'].should == 
          [:blog_title]
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
        @application_layout_page = create(:page, :key => 'application', :locale => I18n.locale)
        @application_layout_footer_copyright_content = create(:page_content, 
          :page => @application_layout_page, :key => "footer_copyright")
        @application_layout_footer_contact_content = create(:page_content, 
          :page => @application_layout_page, :key => "footer_contact")

        # Blog Layout Contents
        @blog_layout_page = create(:page, :key => 'blog/application', :locale => I18n.locale)
        @blog_layout_title_content = create(:page_content, 
          :page => @blog_layout_page, :key => "blog_title")

        # HomeController
        @home_controller = HomeController.new
        @home_page = create(:page, :key => @home_controller.controller_path, :locale => I18n.locale)
        @home_body_content = create(:page_content, :page => @home_page, :key => "body")
        @home_side_content = create(:page_content, :page => @home_page, :key => "side")

        # ContactController
        @contact_controller = ContactController.new
        @contact_page = create(:page, :key => @contact_controller.controller_path, :locale => I18n.locale)
        @contact_body_content = create(:page_content, :page => @contact_page, :key => "body")
        @contact_message_content = create(:page_content, :page => @contact_page, :key => "message")

        # Blog::HomeController
        @blogs_home_controller = Blog::HomeController.new
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

        context "with custom blog layout" do
          before :each do
            HomeController.layout     'blog/application'
            ContactController.layout  'blog/application'
          end

          context "HomeController" do
            it "should retrieve the correct content for :body" do
              @home_controller.manageable_content_for(:body).should == @home_body_content.content
            end
            it "should retrieve the correct content for :side" do
              @home_controller.manageable_content_for(:side).should == @home_side_content.content
            end
            it "should retrieve the correct content for :blog_title" do
              @home_controller.manageable_content_for(:blog_title).should == 
                @blog_layout_title_content.content
            end
          end

          context "ContactController" do
            it "should retrieve the correct content for :body" do
              @contact_controller.manageable_content_for(:body).should == @contact_body_content.content
            end
            it "should retrieve the correct content for :message" do
              @contact_controller.manageable_content_for(:message).should == @contact_message_content.content
            end
            it "should retrieve the correct content for :blog_title" do
              @home_controller.manageable_content_for(:blog_title).should == 
                @blog_layout_title_content.content
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