class TopicsController < ApplicationController
  include TopicsConcern

  before_filter :authenticate_user!, except: [:index, :show]
  after_filter  :update_hits, only: :show

  def index
    @topics = Topic.page(params[:page]).includes(:node, :user)
    @nodes = @topics.map(&:node).uniq.take(3)
  end

  def show
    @replies = @topic.replies.includes(:user, :like_users)
  end

  def new
    @node = Node.find_by key: params[:key]
    @node || redirect_to(root_path, alert: I18n.t('node_missing')) && return

    if @node.approved?
      @topic = @node.topics.new
    else
      redirect_to root_url, alert: I18n.t('node_not_approved')
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
    @topic.hits.incr
  end
end
