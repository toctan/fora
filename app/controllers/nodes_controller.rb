class NodesController < ApplicationController
  def show
    @node = Node.find_by key: params[:key]

    if @node
      @topics = @node.topics.paginate(page: params[:page])
    else
      redirect_to root_path, alert: 'No such node.'
    end
  end
end
