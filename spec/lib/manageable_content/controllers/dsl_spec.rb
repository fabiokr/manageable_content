require 'spec_helper'

describe "The Controller Dsl" do

  context "manageable_content_for method" do
    it "should configure the content keys for the HomeController" do
      HomeController.manageable_content_for.should == [:body, :side]
    end
    it "should configure the content keys for the ContactController" do
      ContactController.manageable_content_for.should == [:body, :message]
    end
  end

  context "manageable_layout_content_for method" do
    it "should configure the layout content keys for the ApplicationController" do
      ApplicationController.manageable_layout_content_for.should == [:footer_copyright, :footer_contact]
    end
  end

end