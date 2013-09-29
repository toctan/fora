class Reply < ActiveRecord::Base
  include Mentionable

  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user,  counter_cache: true

  validates_presence_of :body, :topic_id, :user_id

  default_scope -> { order('updated_at DESC') }

  self.per_page = 20

  def send_notifications
    if user != topic.user
      Notification::TopicReply.create user: topic.user, reply: self
    end
    super
  end

  private

  def mentioned_users
    super - [topic.user]
  end

  def mention_scan_text
    body
  end
end
