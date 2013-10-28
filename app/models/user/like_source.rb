class User
  module LikeSource
    extend ActiveSupport::Concern

    included do
      has_many :likes, dependent: :destroy
    end

    def like(target)
      likes.create(likeable: target)
    end

    def dislike(target)
      likes.where(likeable: target).first.try(:destroy)
    end

    def liked?(target)
      likes.where(likeable: target).present?
    end

    alias_method :likes?, :liked?
  end
end
