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
    context "for a HomeController instance with configured pages" do
      before :each do
        @controller = HomeController.new

        @page        = ManageableContent::Page.new
        @page.key    = @controller.controller_path
        @page.locale = I18n.locale
        @page.save!

        @body_content         = @page.page_contents.build
        @body_content.key     = :body
        @body_content.content = "The body content"
        @body_content.save!

        @side_content         = @page.page_contents.build
        @side_content.key     = :side
        @side_content.content = "The side content"
        @side_content.save!
      end

      context "manageable_content_for helper" do
        it "should retrieve the correct content for :body" do
          @controller.manageable_content_for(:body).should == @body_content.content
        end
        it "should retrieve the correct content for :side" do
          @controller.manageable_content_for(:side).should == @side_content.content
        end
      end
    end
  end

end