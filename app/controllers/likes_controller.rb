class LikesController < ApplicationController
  before_filter :require_login
  before_filter :find_likeable

  def create_or_destroy
    current_user.like_or_dislike @likeable

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def find_likeable
    @likeable = params[:type].camelcase.constantize.find params[:id]
  end
end
