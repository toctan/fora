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
    current_user.star_topic(params[:id].to_i)

    redirect_to :back
  end

  def unstar
    current_user.unstar_topic(params[:id].to_i)

    redirect_to :back
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body)
  end
end
