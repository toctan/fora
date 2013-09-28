class Reply < ActiveRecord::Base
  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user,  counter_cache: true

  validates_presence_of :body, :topic_id, :user_id

  default_scope -> { order('updated_at DESC') }

  after_create :send_topic_reply_notification

  self.per_page = 20

  private

  def send_topic_reply_notification
    if user_id != topic.user_id
      Notification::TopicReply.create user_id: topic.user_id, reply_id: id
    end
  end
end
