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
    @node = Node.find_by key: params[:key]
    if @node
      @topic = @node.topics.new
    else
      redirect_to root_url, alert: 'No such node.'
    end
  end

  def create
    @topic = current_user.topics.build(topic_params)
    @topic.node = Node.find(params[:node_id])

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
