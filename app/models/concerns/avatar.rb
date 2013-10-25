module Avatar
  extend ActiveSupport::Concern

  included do
    attr_reader :avatar_remote_url

    has_attached_file :avatar, styles: { normal: '40x40>', thumb: '22x22>' },
                               path:   ':rails_root/public/uploads/assets/users/:id/:style/:filename',
                               url:    '/uploads/assets/users/:id/:style/:filename'

    validates_attachment_content_type :avatar, content_type: ['image/png', 'image/jpeg']
    validates_attachment_size :avatar,
                              less_than: 500.kilobytes,
                              message: 'must less than 500KB'
  end

  def avatar_remote_url=(url)
    self.avatar = URI.parse(url)
    @avatar_remote_url = url
  end
end
