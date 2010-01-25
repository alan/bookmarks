require 'spec_helper'

describe BookmarksController do
  context "create" do
    it "should create a new bookmark" do
      request.env["HTTP_REFERER"] = "test.local"
      WWW::Mechanize.stub!(:new).and_return(mock().as_null_object)
      
      post :create, {:bookmark => {:url => "http://my.url"}}
      Bookmark.count.should == 1
    end
  end
end
