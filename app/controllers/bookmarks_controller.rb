class BookmarksController < ApplicationController
  def create
    bookmark = Bookmark.new(params[:bookmark])
    if bookmark.save
      flash[:notice] = "Bookmark saved"
    else
      flash[:error] = "The bookmark is invalid. Did you forget http at the beginning?"
    end
    redirect_to :back
  end
  
  def show
    @bookmark = Bookmark.find(params[:id])
  end
end
