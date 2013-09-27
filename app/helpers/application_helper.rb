module ApplicationHelper
  def avatar_tag(user, opts = {})
    link = opts.include?(:link) ? opts[:link] : true
    name = opts.include?(:name) ? opts[:name] : true
    size =  opts[:size] || :normal
    img = avatar_img(user, size)

    img << user.username if name

    if link
      link_to img, '',  class: "name"
    else
      img
    end
  end

  def font_icon(name, size = nil)
    if size
      content_tag(:i, nil, class: "icon-#{size} icon-#{name}")
    else
      content_tag(:i, nil, class: "icon-#{name}")
    end
  end

  private

  def user_avatar_width_for_size(size)
    case size
    when :thumb  then 22
    when :normal then 40
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

    image_tag(img_src)
  end
end
