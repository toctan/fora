class Reply < ActiveRecord::Base
  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user,  counter_cache: true

  validates_presence_of :body, :topic_id, :user_id

  default_scope -> { order('updated_at DESC') }

  after_create :send_notifications

  self.per_page = 20

  private

  def send_notifications
    user.notify(topic.user_id, topic_id, body) unless user == topic.user
  end
end
