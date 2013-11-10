module LikesHelper
  def like_tag(target, opts = {})
    text = opts[:text] ? like_text(target) : like_icon(target)
    link_to text, like_path(target.class, target.id), method: :post, id: 'js-like'
  end

  private

  def like_icon(target)
    klass = current_user.likes?(target) ? 'liked' : 'empty'
    semantic_icon('heart', klass)
  end

  def like_text(target)
    current_user.likes?(target) ? I18n.t('dislike') : I18n.t('like')
  end
end
