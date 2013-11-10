module UsersHelper
  def username_tag(username)
    link_to username, '#', class: 'username'
  end

  def avatar_tag(user, size = :normal, opts = {})
    link_to avatar_img(user, size), '#', class: 'avatar'
  end

  private

  def user_avatar_width_for_size(size)
    case size
    when :small  then 24
    when :thumb  then 32
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
