require 'spec_helper'

describe ManageableContent::PageContent do

  context "fields" do
    it { should have_db_column(:page_id).of_type(:integer) }
    it { should have_db_column(:key).of_type(:string) }
    it { should have_db_column(:content).of_type(:text) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }

    it { should have_db_index([:page_id, :key]).unique(true) }
  end

  context "mass assignment" do
    it { should allow_mass_assignment_of(:content) }

    it { should_not allow_mass_assignment_of(:key) }
    it { should_not allow_mass_assignment_of(:page_id) }
    it { should_not allow_mass_assignment_of(:updated_at) }
    it { should_not allow_mass_assignment_of(:created_at) }
  end

  context "validations" do
    it { should validate_presence_of(:page_id) }
    it { should validate_presence_of(:key) }
  end

  context "associations" do
    it { should belong_to :page }
  end

end