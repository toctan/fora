module NodesConcern

  private

  def node_params
    params.require(:node).permit(:name, :key)
  end
end
