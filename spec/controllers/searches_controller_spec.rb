require 'spec_helper'

describe SearchesController do

  it "should handle json requests" do
    b1, b2 = Bookmark.make(:url => "http://www.bbc.co.uk"), Bookmark.make(:url => "http://www.bbc.co.uk/iplayer")
    get :show, :query => "player", :format => 'json'
    @response.body.should == [[b2.url, b2.id]].to_json
  end

end