class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true


  has_one :like_notification, -> { where kind: 'like' },
                              class_name: 'Notification',
                              dependent: :destroy

  after_create :send_like_notification

  validates_presence_of :user_id, :likeable_id, :likeable_type
  validates_uniqueness_of :user_id, scope: [:likeable_id, :likeable_type]

  private

  def send_like_notification
    return if user == likeable.try(:user)

    create_like_notification(
      target: likeable.user,
      source: user,
      topic: likeable.try(:topic) || likeable,
      reply: likeable.try(:topic) && likeable
      )
  end
end

# == Schema Information
#
# Table name: likes
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  likeable_id   :integer
#  likeable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_likes_on_likeable_id_and_likeable_type              (likeable_id,likeable_type)
#  index_likes_on_user_id                                    (user_id)
#  index_likes_on_user_id_and_likeable_id_and_likeable_type  (user_id,likeable_id,likeable_type) UNIQUE
#
