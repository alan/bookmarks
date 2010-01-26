class SearchesController < ApplicationController
  def show
    @results = Bookmark.search(params[:query])
  end
  
  def suggest
    results = Bookmark.search(params[:query])
    render :json => results.collect{|r| [r.url, r.id]}.to_json
  end
end