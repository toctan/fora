class NodesController < ApplicationController
  def show
    @node = Node.find_by key: params[:key]
    @topics = @node.topics.paginate(page: params[:page])
  end
end
