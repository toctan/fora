class Notification::TopicReply < Notification::Base
  belongs_to :reply

  delegate :body, to: :reply
end
