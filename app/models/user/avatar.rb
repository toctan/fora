class User
  module Avatar
    extend ActiveSupport::Concern

    # TODO: duplication with node image logic
    included do
      attr_reader :avatar_remote_url

      has_attached_file :avatar, styles: { large: '64x64>', normal: '48x48>', thumb: '32x32>', small: '24x24>'}

      validates_attachment :avatar, content_type: { content_type: /^image\/(jpg|jpeg|png)$/ },
                                    size: { less_than: 2.megabytes}
    end

    def avatar_remote_url=(url)
      self.avatar = URI.parse(url)
      @avatar_remote_url = url
    end
  end
end
