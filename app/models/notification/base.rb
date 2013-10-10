class Notification::Base < ActiveRecord::Base
  self.table_name = 'notifications'

  belongs_to :user

  delegate :username, to: :user

  scope :unread, -> { where(is_read: false) }
end
