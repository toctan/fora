class Notification::TopicReply < Notification::Base
  belongs_to :reply

  delegate :body, :topic, :user, to: :reply
end

# == Schema Information
#
# Table name: notifications
#
#  id               :integer          not null, primary key
#  user_id          :integer
#  reply_id         :integer
#  is_read          :boolean          default(FALSE)
#  mentionable_id   :integer
#  mentionable_type :string(255)
#  type             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_notifications_on_is_read                              (is_read)
#  index_notifications_on_mentionable_id_and_mentionable_type  (mentionable_id,mentionable_type)
#  index_notifications_on_reply_id                             (reply_id)
#  index_notifications_on_user_id                              (user_id)
#

