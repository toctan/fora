module UsersHelper
  def username_tag(username)
    link_to username, '#', class: 'username' if username
  end

  def avatar_tag(user, size = :normal, opts = {})
    link_to avatar_img(user, size), '#', class: 'avatar', title: user.username
  end

  private

  def avatar_img(user, size)
    image_tag user.avatar.url(size)
  end
end
