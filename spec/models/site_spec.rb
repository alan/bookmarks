require 'spec_helper'

describe Site do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Site.create!(@valid_attributes)
  end
end
