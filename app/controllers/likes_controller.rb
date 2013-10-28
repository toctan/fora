class LikesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_likeable

  def create
    current_user.like @likeable

    redirect_to :back
  end

  def destroy
    current_user.dislike @likeable

    redirect_to :back
  end

  private

  def find_likeable
    @likeable = params[:type].camelcase.constantize.find params[:id]
  end
end
