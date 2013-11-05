class NodesController < ApplicationController
  before_filter :custom_layout, only: :index

  def index
    @nodes = Node.page(params[:page])
  end

  def show
    @node = Node.find_by key: params[:key]

    if @node
      @topics = @node.topics.page(params[:page]).includes(:user)
    else
      redirect_to root_path, alert: 'No such node.'
    end
  end

  private

  def custom_layout
    @custom_layout = true
  end
end
