module Avatar
  extend ActiveSupport::Concern

  included do
    attr_reader :avatar_remote_url

    has_attached_file :avatar, styles: { large: '64x64>', normal: '48x48>', thumb: '32x32>', small: '24x24>'},
                               path:   ':rails_root/public/uploads/assets/users/:id/:style/:filename',
                               url:    '/uploads/assets/users/:id/:style/:filename'

    validates_attachment :avatar, content_type: { content_type: ['image/png', 'image/jpeg'] },
                                  size: { less_than: 500.kilobytes }
  end

  def avatar_remote_url=(url)
    self.avatar = URI.parse(url)
    @avatar_remote_url = url
  end
end
