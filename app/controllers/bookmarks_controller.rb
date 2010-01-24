class BookmarksController < ApplicationController
  def create
    bookmark = Bookmark.new(params[:bookmark])
    if bookmark.save
      flash[:notice] = "Bookmark saved"
    end
    redirect_to :back
  end
  
  def show
    @bookmark = Bookmark.find(params[:id])
  end
end
