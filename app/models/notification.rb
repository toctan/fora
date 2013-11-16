class Notification < ActiveRecord::Base
  belongs_to :source, class_name: 'User'
  belongs_to :target, class_name: 'User'
  belongs_to :topic
  belongs_to :reply

  validates_presence_of :source_id, :target_id, :topic_id, :kind

  delegate :username, to: :source, prefix: true

  scope :unread, -> { where(is_read: false) }

  def body
    reply.try(:body) || topic.try(:body)
  end
end
