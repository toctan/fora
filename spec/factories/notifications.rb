FactoryGirl.define do
  factory :notification_base, class: Notification::Base do
    user

    factory :notification_topic_reply, class: Notification::TopicReply do
      reply
    end

    factory :notification_mention, class: Notification::Mention do
      association :mentionable, factory: :topic
    end
  end
end
