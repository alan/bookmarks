require 'spec_helper'

describe Searchable do
  it "should raise error if used in a model with no searchable columns" do
    A = Class.new
    A.stub!(:table_exists?).and_return(true)
    A.stub!(:column_names).and_return(['id', 'created_at', 'updated_at', 'associated_id'])
    lambda{ A.send(:include, Searchable) }.should raise_error
  end
  
  it "should search one field when there is only one searchable field" do
    B = Class.new
    B.stub!(:table_exists?).and_return(true)
    B.stub!(:column_names).and_return(['id', 'created_at', 'updated_at', 'associated_id', "test"])
    B.send(:include, Searchable)
    B.should_receive(:all).with({:conditions => ["test LIKE ?", '%to_search%']})
    B.search('to_search')
  end
  
  it "should search by multiple fields" do
    C = Class.new
    C.stub!(:table_exists?).and_return(true)
    C.stub!(:column_names).and_return(['id', 'created_at', 'updated_at', 'associated_id', "test", "spec"])
    C.send(:include, Searchable)
    C.should_receive(:all).with({:conditions => ["test LIKE ? OR spec LIKE ?", '%to_search%', '%to_search%']})
    C.search('to_search')
  end
end