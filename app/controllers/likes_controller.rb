class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_likeable

  def create_or_destroy
    current_user.like_or_dislike @likeable
    redirect_to :back
  end

  private

  def find_likeable
    @likeable = params[:type].camelcase.constantize.find params[:id]
  end
end
