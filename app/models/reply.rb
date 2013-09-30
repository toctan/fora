class Reply < ActiveRecord::Base
  include Mentionable

  after_create :send_notification_to_topic_owner

  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user,  counter_cache: true

  has_one :reply_notification, class_name: 'Notification::TopicReply',
                               dependent: :destroy

  validates_presence_of :body, :topic_id, :user_id
  validates_numericality_of :topic_id, :user_id

  default_scope -> { order('updated_at DESC') }

  self.per_page = 20

  private

  def send_notification_to_topic_owner
    create_reply_notification user: topic.user if user != topic.user
  end

  def mentioned_users
    super - [topic.user] # or topic user will get two notification
  end

  def mention_scan_text
    body
  end
end
