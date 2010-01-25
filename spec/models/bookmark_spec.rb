require 'spec_helper'

describe Bookmark do

  describe "validations" do
    it "should require a url" do
      bookmark = Bookmark.new
      bookmark.should_not be_valid
      bookmark.errors.on(:url).should_not be_nil
    end
    
    it "shouuld requre the url to be a host" do
      bookmark = Bookmark.new(:url => "nothing")
      bookmark.should_not be_valid
      bookmark.errors.on(:url).should_not be_nil
    end
  end
  
  context "named_scopes" do
    before(:each) do
      @very_old_bookmark = Bookmark.make(:created_at => 1.year.ago)
      @old_bookmark = Bookmark.make(:created_at => 1.month.ago)
      @bookmark = Bookmark.make(:created_at => 1.week.ago)
      @new_bookmark = Bookmark.make(:created_at => 1.day.ago)
    end
    
    describe "#by_newest" do
      it "should return bookmarks ordered by created_at" do
        Bookmark.by_newest.should == [@new_bookmark, @bookmark, @old_bookmark, @very_old_bookmark]
      end
    end
    
    describe "#limit" do
      it "should only return the maximum number of bookmarks specified" do
        Bookmark.limit(3).all.count.should be(3)
        Bookmark.limit(2).all.count.should be(2)
      end
    end
  end
  
  describe "a bookmark should belong to a site" do
    it "should belong to a site and create it if necessary" do
      bookmark = Bookmark.create!(:url => "http://www.bbc.co.uk")
      Site.count.should == 1
      bookmark.site.should == Site.first
    end
    
    it "should reuse a site if it already exists" do
      bookmark = Bookmark.create!(:url => "http://www.bbc.co.uk")
      bookmark2 = Bookmark.create!(:url => "http://www.bbc.co.uk/iplayer")
      Site.count.should == 1
      bookmark2.site.should == Site.first
    end
  end
  
  describe "#search" do
    it "should search by url" do
      bookmark = Bookmark.make(:url => "http://www.bbc.co.uk")
      results = Bookmark.search("bbc")
      results.size.should be(1)
      results.should include(bookmark)
      
      bookmark2 = Bookmark.make(:url => "http://www.bbc.co.uk/iplayer")
      results = Bookmark.search("bbc")
      results.size.should be(2)
      results.should include(bookmark)
      results.should include(bookmark2)
    end
  end
end
