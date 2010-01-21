require 'spec_helper'

describe Bookmark do
  before(:each) do
    @valid_attributes = {
      :url => 'my.url'
    }
  end

  it "should create a new instance given valid attributes" do
    lambda{ Bookmark.create!(@valid_attributes) }.should_not raise_error
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
end
