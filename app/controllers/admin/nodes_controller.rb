class Admin::NodesController < Admin::AdminController
  include NodesConcern

  def create
    @node = current_user.nodes.build(node_params.merge(approved: true))

    if @node.save
      redirect_to @node, notice: I18n.t('create_node_success')
    else
      render 'new'
    end
  end
end
