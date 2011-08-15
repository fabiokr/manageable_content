require 'spec_helper'

describe ManageableContent::Page do

  context "fields" do
    it { should have_db_column(:key).of_type(:string) }
    it { should have_db_column(:locale).of_type(:string) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    it { should have_db_index([:key, :locale]).unique(true) }
  end

  context "mass assignment" do
    it { should_not allow_mass_assignment_of(:key) }
    it { should_not allow_mass_assignment_of(:locale) }
    it { should_not allow_mass_assignment_of(:updated_at) }
    it { should_not allow_mass_assignment_of(:created_at) }
  end

  context "validations" do
    it { should validate_presence_of(:locale) }
  end

  context "associations" do
    it { should have_many(:page_contents) }
  end

  context "class methods" do

    context "generate!" do
      before :each do
        ManageableContent::Page.generate!
      end

      context "Layout" do
        it "should generate contents" do
          page = ManageableContent::Page.for_key(nil)

          page.locale.should == I18n.locale.to_s
          page.page_contents.size.should == 2
          page.page_content_for_key(:footer_copyright).should_not be_nil
          page.page_content_for_key(:footer_contact).should_not   be_nil
        end
      end

      context "HomeController" do
        it "should generate contents" do
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
        it "should generate contents" do
          page = ManageableContent::Page.for_key(ContactController.controller_path)

          page.locale.should == I18n.locale.to_s
          page.page_contents.size.should == 4
          page.page_content_for_key(:title).should_not    be_nil
          page.page_content_for_key(:keywords).should_not be_nil
          page.page_content_for_key(:body).should_not     be_nil
          page.page_content_for_key(:message).should_not  be_nil
        end
      end

      context "BlogController" do
        it "should generate contents" do
          page = ManageableContent::Page.for_key(BlogController.controller_path)

          page.locale.should == I18n.locale.to_s
          page.page_contents.size.should == 2
          page.page_content_for_key(:title).should_not    be_nil
          page.page_content_for_key(:keywords).should_not be_nil
        end
      end
    end

  end

  context "instance methods" do
    before :each do
      @page        = ManageableContent::Page.new
      @page.key    = 'the/example'
      @page.locale = I18n.locale
      @page.save!

      @page_content         = @page.page_contents.build
      @page_content.key     = 'mycontent'
      @page_content.content = 'My content'
      @page_content.save!
    end

    it "should retrieve correct page with :for_key" do
      ManageableContent::Page.for_key('the/example').should == @page
    end

    it "should retrieve correct content with :page_content_for_key" do
      @page.page_content_for_key(:mycontent).should == @page_content
    end
  end
end