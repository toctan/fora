class Reply < ActiveRecord::Base
  include Likeable
  include Mentionable

  default_scope -> { order('created_at ASC') }

  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user,  counter_cache: true

  has_one :reply_notification, class_name: 'Notification::TopicReply',
                               dependent: :destroy

  validates_presence_of :body, :topic_id, :user_id

  after_create :send_notification_to_topic_owner

  delegate :username, to: :user

  private

  def send_notification_to_topic_owner
    create_reply_notification user: topic.user if user != topic.user
  end

  def mentioned_users
    super - [topic.user]
  end

  def mention_scan_text
    body
  end
end

# == Schema Information
#
# Table name: replies
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  body_html  :text             not null
#  user_id    :integer
#  topic_id   :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_replies_on_topic_id  (topic_id)
#  index_replies_on_user_id   (user_id)
#
