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
    it { should allow_mass_assignment_of(:page_contents_attributes) }

    it { should_not allow_mass_assignment_of(:key) }
    it { should_not allow_mass_assignment_of(:locale) }
    it { should_not allow_mass_assignment_of(:updated_at) }
    it { should_not allow_mass_assignment_of(:created_at) }

    it { should allow_mass_assignment_of(:page_contents_attributes) }
  end

  context "validations" do
    it { should validate_presence_of(:locale) }
  end

  context "associations" do
    it { should have_many(:page_contents) }
  end

  context "instance methods" do
    before :each do
      @page         = create(:page, :key => 'the/example', :locale => I18n.locale)
      @page_content = create(:page_content, :page => @page, :key => 'mycontent')
    end

    it "should retrieve correct content with :page_content" do
      @page.page_content(:mycontent).should == @page_content
    end

    it "should retrieve correct content with :content" do
      @page.content(:mycontent).should == @page_content.content
    end
  end
end