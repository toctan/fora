module LikesHelper
  def like_tag(target, opts = {})
    text = opts[:text] ? like_text(target) : like_icon(target)
    link_to text, like_path(target.class, target.id), method: :post, id: 'js-like'
  end

  private

  def like_icon(target)
    icon target.liked_by?(current_user) ? 'heart' : 'heart-empty'
  end

  def like_text(target)
    target.liked_by?(current_user) ? I18n.t('dislike') : I18n.t('like')
  end
end
