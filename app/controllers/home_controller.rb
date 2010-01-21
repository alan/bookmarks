class HomeController < ApplicationController
  def index
    @bookmark = Bookmark.new
    @recent_bookmarks = Bookmark.by_newest.limit(3)
  end
end
