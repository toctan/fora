module Autohtmlable
  extend ActiveSupport::Concern

  included do
    auto_html_for :body do
      at
      image
      youku
      youtube
      vimeo
      twitter
      gist
      link target: '_blank', rel: 'nofollow'
      simple_format
    end
  end
end
