module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable
    has_many :like_users, through: :likes, source: :user
  end

  def liked_by?(user)
    like_users.include?(user)
  end
end
