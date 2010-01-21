require 'spec_helper'

describe BookmarksController do
  context "create" do
    it "should create a new bookmark" do
      request.env["HTTP_REFERER"] = "test.local"
      post :create, {:bookmark => {:url => "my.url"}}
      Bookmark.count.should == 1
    end
  end
end
