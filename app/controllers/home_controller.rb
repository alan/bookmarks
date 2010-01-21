class HomeController < ApplicationController
  def index
    @bookmark = Bookmark.new
  end
end
