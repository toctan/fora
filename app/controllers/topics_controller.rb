class TopicsController < ApplicationController
  include TopicsConcern

  before_filter :authenticate_user!, except: [:index, :show]
  after_filter  :update_hits, only: :show

  def index
    @topics = Topic.page(params[:page]).includes(:node, :user)
    @nodes = Node.first(3)
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

  private

  def topic_params
    params.require(:topic).permit(:title, :body, :node_id)
  end

  def update_hits
    @topic.update_hits
  end
end
