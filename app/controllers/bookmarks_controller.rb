class BookmarksController < ApplicationController
  before_filter :require_login

  def create_or_destroy
    current_user.bookmark_or_unbookmark params[:id].to_i

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def index
    @topics = Topic.where(id: current_user.bookmarks).
      page(params[:page]).includes(:node, :user)
  end
end
