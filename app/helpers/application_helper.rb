module ApplicationHelper
  def avatar_url(user, type = :thumb, size = 20)
    if user.avatar?
      user.avatar.url(type)
    else
      gravatar_id = Digest::MD5.hexdigest(user.email)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&f=y&d=mm"
    end
  end
end
