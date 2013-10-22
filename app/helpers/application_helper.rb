module ApplicationHelper
  def avatar_tag(user, size = :normal, opts = {})
    img = avatar_img(user, size, opts[:img_class])

    link_to img, '#', class: "name #{opts[:class]}"
  end

  def avatar_img(user, size, klass = 'rounded')
    img_src =
      if user.avatar?
        user.avatar.url(size)
      else
        width = user_avatar_width_for_size(size)
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{width}&d=identicon"
      end

    image_tag(img_src, class: "#{klass} ui image")
  end

  def icon(name, klass = nil, data = {})
    content_tag(:i, nil, class: "#{name} #{klass} icon", data: data)
  end

  private

  def user_avatar_width_for_size(size)
    case size
    when :thumb  then 24
    when :normal then 40
    when :large  then 64
    else size
    end
  end

  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end
end
