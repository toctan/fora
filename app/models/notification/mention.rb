class Notification::Mention < Notification::Base
  belongs_to :mentionable, polymorphic: true

  delegate :body, :topic, :user, to: :mentionable
end
