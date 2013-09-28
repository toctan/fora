class Notification::Mention < Notification::Base
  belongs_to :mentionable, polymorphic: true

  delegate :body, to: :mentionable
end
