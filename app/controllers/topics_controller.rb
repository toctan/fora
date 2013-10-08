class TopicsController < ApplicationController

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_topic, only: [:show, :destroy]

  load_and_authorize_resource

  def index
    @topics = Topic.page(params[:page]).includes(:user)
    @nodes = Node.take(Node.limit)
  end

  def show
    @replies = @topic.replies.page(params[:page]).includes(:user)
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

  def destroy
    redirect_to root_url, notice: 'Delete topic successfully' if @topic.destroy
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

  def find_topic
    @topic = Topic.find(params[:id])
  end
end
