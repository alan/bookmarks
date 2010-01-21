class BookmarksController < ApplicationController
  def create
    flash[:notice] = "Bookmark saved"
    redirect_to :back
  end
end
