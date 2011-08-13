require 'spec_helper'

describe "The Engine" do

  it "should define the table_name_prefix for the engine" do
    ManageableContent.table_name_prefix.should == "manageable_content_"
  end

end