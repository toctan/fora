class Notification < ActiveRecord::Base

  default_scope -> { order('updated_at DESC') }
  scope :unread, -> { where(is_read: false) }

  belongs_to :source, class_name: 'User'
  belongs_to :target, class_name: 'User'
  belongs_to :topic
  belongs_to :reply

  validates_presence_of :source_id, :target_id, :topic_id, :kind

  delegate :username, to: :source, prefix: true

  def body
    reply.try(:body) || topic.try(:body)
  end
end

# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  target_id  :integer
#  source_id  :integer
#  topic_id   :integer
#  reply_id   :integer
#  like_id    :integer
#  is_read    :boolean          default(FALSE)
#  kind       :string(255)      not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_notifications_on_is_read    (is_read)
#  index_notifications_on_like_id    (like_id)
#  index_notifications_on_reply_id   (reply_id)
#  index_notifications_on_source_id  (source_id)
#  index_notifications_on_target_id  (target_id)
#  index_notifications_on_topic_id   (topic_id)
#
