class TopicsController < ApplicationController
  def index
    @topics = Topic.paginate(page: params[:page])
  end

  def show
    @topic = Topic.find(params[:id])
  end
end
