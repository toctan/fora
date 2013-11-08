class Admin::NodesController < Admin::AdminController
  def create
    @node = Node.new(node_params.merge(approved: true))

    if @node.save
      redirect_to @node, notice: I18n.t('create_node_success')
    else
      render 'new'
    end
  end

  private

  def node_params
    params.require(:node).permit(:name, :key)
  end
end
