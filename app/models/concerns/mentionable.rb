module Mentionable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, as: :mentionable,
                             class_name: 'Notification::Mention',
                             dependent: :destroy

    after_create :send_notifications
  end

  MENTION_REGEXP = /@(\w{1,17})/

  private

  def send_notifications
    mentioned_users.each do |u|
      notifications.create user: u
    end
  end

  def mentioned_users
    User.where(username: mentioned_usernames)
  end

  def mentioned_usernames
    mention_scan_text.scan(MENTION_REGEXP).flatten.uniq - [user.username] # except sender himself
  end

  def mention_scan_text
    raise "mention_scan_text was not implemented in #{self.class.to_s}"
  end
end
