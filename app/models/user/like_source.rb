class User
  module LikeSource
    extend ActiveSupport::Concern

    included do
      has_many :likes, dependent: :destroy
    end

    def like_or_dislike(target)
      if likes?(target)
        dislike(target)
      else
        like(target)
      end
    end

    def likes?(target)
      likes.where(likeable: target).present?
    end

    def like(target)
      likes.create(likeable: target)
    end

    def dislike(target)
      likes.where(likeable: target).first.try(:destroy)
    end
  end
end
