require 'spec_helper'

describe BookmarksController do
  context "create" do
    it "should create a new bookmark" do
      request.env["HTTP_REFERER"] = "test.local"
      WWW::Mechanize.stub!(:new).and_return(mock().as_null_object)
      
      post :create, {:bookmark => {:url => "http://my.url"}}
      Bookmark.count.should == 1
    end
    
    it "should set the flash notice when invalid" do
      request.env["HTTP_REFERER"] = "test.local"
      post :create, {:bookmark => {:url => "my.url"}}
      flash[:error].should_not be_blank
      Bookmark.count.should be(0)
    end
  end
end
