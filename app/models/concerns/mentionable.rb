module Mentionable
  extend ActiveSupport::Concern

  included do
    has_many :notifications, -> { where kind: 'mention' },
                             dependent: :destroy

    after_create :send_notifications
  end

  MENTION_REGEXP = /@(\w{1,17})/

  private

  def send_notifications
    mentioned_users.each do |u|
      notifications.create target: u, source: user, topic: try(:topic) || self
    end
  end

  def mentioned_users
    User.where(username: mentioned_usernames)
  end

  def mentioned_usernames
    mention_scan_text.scan(MENTION_REGEXP).flatten.uniq - [username] # except sender himself
  end

  def mention_scan_text
    body
  end
end
