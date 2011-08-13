require 'spec_helper'

describe "The Engine Version" do

  it "should be retrievable" do
    assert ManageableContent::VERSION
  end

end