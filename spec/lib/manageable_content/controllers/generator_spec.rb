require 'spec_helper'

describe ManageableContent::Controllers::Generator do

  context "class methods" do

    context "generate!" do
      before :each do
        ManageableContent::Controllers::Generator.generate!
      end

      context "Layout" do
        it "should have generated contents" do
          page = ManageableContent::Page.for_key(nil)

          page.locale.should == I18n.locale.to_s
          page.page_contents.size.should == 2
          page.page_content_for_key(:footer_copyright).should_not be_nil
          page.page_content_for_key(:footer_contact).should_not   be_nil
        end
      end

      context "HomeController" do
        it "should have generated contents" do
          page = ManageableContent::Page.for_key(HomeController.controller_path)

          page.locale.should == I18n.locale.to_s
          page.page_contents.size.should == 4
          page.page_content_for_key(:title).should_not    be_nil
          page.page_content_for_key(:keywords).should_not be_nil
          page.page_content_for_key(:body).should_not     be_nil
          page.page_content_for_key(:side).should_not     be_nil
        end
      end

      context "ContactController" do
        it "should have generated contents" do
          page = ManageableContent::Page.for_key(ContactController.controller_path)

          page.locale.should == I18n.locale.to_s
          page.page_contents.size.should == 4
          page.page_content_for_key(:title).should_not    be_nil
          page.page_content_for_key(:keywords).should_not be_nil
          page.page_content_for_key(:body).should_not     be_nil
          page.page_content_for_key(:message).should_not  be_nil
        end
      end

      context "Blogs::HomeController" do
        it "should have generated contents" do
          page = ManageableContent::Page.for_key(Blogs::HomeController.controller_path)

          page.locale.should == I18n.locale.to_s
          page.page_contents.size.should == 2
          page.page_content_for_key(:title).should_not    be_nil
          page.page_content_for_key(:keywords).should_not be_nil
        end
      end

      it "should generate pages for all available locales"
      it "should generate pages on development mode"
      it "should be possible to ignore namespaces"
      it "should be possible to have manageable content for different layouts"
    end

  end

end