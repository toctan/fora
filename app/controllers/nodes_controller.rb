class NodesController < ApplicationController
  def show
    @node = Node.find_by key: params[:key]

    if @node
      @topics = @node.topics.page(params[:page]).includes(:user)
    else
      redirect_to root_path, alert: 'No such node.'
    end
  end
end
