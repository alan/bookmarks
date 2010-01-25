class SearchesController < ApplicationController
  def show
    @results = Bookmark.search(params[:query])
  end
end