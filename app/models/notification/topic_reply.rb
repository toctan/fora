class Notification::TopicReply < Notification::Base
  belongs_to :reply

  delegate :body, :topic, :user, to: :reply
end
