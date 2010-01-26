class SearchesController < ApplicationController
  def show
    @results = Bookmark.search(params[:query])
    
    respond_to do |format|
      format.html
      format.json {render :json => @results.collect{|r| [r.url, r.id]}.to_json}
    end
  end
end