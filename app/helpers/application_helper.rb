module ApplicationHelper
  def avatar_tag(user, size = :normal, opts = {})
    link = opts[:link] || true
    name = opts[:name] || true
    img = avatar_img(user, size)

    img << user.username if name

    if link
      link_to img, '',  class: "name"
    else
      raw img
    end
  end

  def font_icon(name, size = 'large')
    content_tag(:i, nil, class: "icon-#{size} icon-#{name}")
  end

  private

  def user_avatar_width_for_size(size)
    case size
    when :thumb  then 20
    when :normal then 48
    when :large  then 64
    else size
    end
  end

  def avatar_img(user, size)
    width = user_avatar_width_for_size(size)
    img_src =
      if user.avatar?
        user.avatar.url(size)
      else
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{width}&d=identicon"
      end

    image_tag(img_src, style: "width:#{width}px;height:#{width}px;")
  end
end
