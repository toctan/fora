class BookmarksController < ApplicationController
  before_filter :authenticate_user!

  def create_or_destroy
    current_user.bookmark_or_unbookmark params[:id].to_i
    redirect_to :back
  end
end