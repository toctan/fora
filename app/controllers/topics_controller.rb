class TopicsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

  def index
    @topics = Topic.paginate(page: params[:page])
  end

  def show
    @topic = Topic.find(params[:id])
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = current_user.topics.build(topic_params)

    if @topic.save
      redirect_to @topic
    else
      render 'new'
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
