class User < ActiveRecord::Base
  include Avatar
  include LikeSource
  include Bookmark

  attr_accessor :login

  devise :database_authenticatable,
         :omniauthable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

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
      username:          auth.info.nickname,
      avatar_remote_url: auth.info.image,
      confirmed_at:      Time.now
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

  def password_required?
    super && provider.blank?
  end

  def email_required?
    super && !avatar?
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

  def update_with_password(params = {})
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:current_password)
      update_without_password(params)
    else
      super
    end
  end

  protected

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where([
        'lower(username) = :value OR lower(email) = :value',
        { value: login.downcase }
        ]).first
    else
      where(conditions).first
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  replies_count          :integer          default(0)
#  topics_count           :integer          default(0)
#  admin                  :boolean          default(FALSE), not null
#  bookmarks              :integer          default([])
#  avatar_file_name       :string(255)
#  avatar_content_type    :string(255)
#  avatar_file_size       :integer
#  avatar_updated_at      :datetime
#  username               :string(255)      default(""), not null
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  provider               :string(255)
#  uid                    :string(255)
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_provider_and_uid      (provider,uid) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
