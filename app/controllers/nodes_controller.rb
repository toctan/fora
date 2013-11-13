class NodesController < ApplicationController
  include NodesConcern

  before_filter :custom_layout, only: :index
  before_filter :authenticate_user!, only: [:new, :create]

  def index
    @nodes = Node.approved.page(params[:page])
  end

  def show
    @node = Node.find_by key: params[:key]
    @node || redirect_to(root_path, alert: I18n.t('node_missing')) && return

    if @node.approved?
      @topics = @node.topics.page(params[:page]).includes(:user)
    else
      redirect_to root_path, alert: I18n.t('node_not_approved')
    end
  end

  def new
    @node = Node.new
  end

  def create
    @node =  current_user.nodes.build(node_params)

    if @node.save
      redirect_to root_path, notice: I18n.t('propose_node_success')
    else
      render 'new'
    end
  end

  private

  def node_params
    params.require(:node).permit(:name, :key)
  end

  def custom_layout
    @custom_layout = true
  end
end
