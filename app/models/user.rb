class User < ActiveRecord::Base
  include Avatar
  include LikeSource
  include Bookmark

  has_many :nodes,         dependent: :destroy
  has_many :topics,        dependent: :destroy
  has_many :replies,       dependent: :destroy
  has_many :notifications, dependent: :destroy, foreign_key: 'target_id'

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[A-Za-z_\d]+\z/ },
                       length: { maximum: 17 }

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create(
      provider:          auth.provider,
      uid:               auth.uid,
      username:          auth.info.nickname || auth.info.namenod,
      avatar_remote_url: auth.info.image,
      )
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if session['devise.user_attributes']
        user.attributes = session['devise.user_attributes']
        user.valid?
      end
    end
  end

  def unread_notifications_count
    notifications.unread.count
  end

  def read_notifications
    notifications.unread.update_all(is_read: true)
  end

  def clear_notifications
    notifications.delete_all
  end
end

# == Schema Information
#
# Table name: users
#
#  id                  :integer          not null, primary key
#  uid                 :string(255)
#  username            :string(255)
#  provider            :string(255)
#  admin               :boolean          default(FALSE), not null
#  avatar_file_name    :string(255)
#  avatar_content_type :string(255)
#  avatar_file_size    :integer
#  avatar_updated_at   :datetime
#  replies_count       :integer          default(0)
#  topics_count        :integer          default(0)
#  bookmarks           :integer          default([])
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_users_on_provider_and_uid  (provider,uid) UNIQUE
#  index_users_on_username          (username) UNIQUE
#
