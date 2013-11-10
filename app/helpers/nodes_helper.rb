module NodesHelper
  def node_tag(node, opts = {})
    return unless node
    opts[:class] = 'topic__node'
    opts[:style] = "background-color: #{node.color}" if node.color?
    content_tag(:span, node.name, opts)
  end
end
