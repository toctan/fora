class TopicsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :create]

  def index
    @topics = Topic.paginate(page: params[:page])
  end

  def show
    @topic = Topic.find(params[:id])
    @replies = @topic.replies.paginate(page: params[:page])
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

  def star
    @topic = Topic.find(params[:id])
    current_user.stars << @topic.id
    current_user.stars_will_change!
    current_user.save

    redirect_to @topic
  end

  def unstar
    @topic = Topic.find(params[:id])
    current_user.stars.delete(@topic.id)
    current_user.stars_will_change!
    current_user.save

    redirect_to @topic
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
