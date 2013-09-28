class Notification < ActiveRecord::Base
  belongs_to :actor, class_name: 'User', foreign_key: 'actor_id'
  belongs_to :user
  belongs_to :topic

  scope :unread, -> { where(is_read: false) }
end
