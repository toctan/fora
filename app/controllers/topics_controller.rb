class TopicsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :find_topic,  only: [:show, :destroy]
  after_filter :update_hits, only: :show

  load_and_authorize_resource

  def index
    @topics = TopicList.list 1
    @nodes =  @topics.take(3).map(&:node)
  end

  def show
    @replies = @topic.replies.includes(:user)
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

    if @topic.save
      redirect_to @topic
    else
      render 'new'
    end
  end

  def destroy
    redirect_to root_url, notice: 'Delete topic successfully' if @topic.destroy
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :node_id)
  end

  def find_topic
    @topic = Topic.find(params[:id])
  end

  def update_hits
    @topic.update_hits
  end
end
