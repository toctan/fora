class User < ActiveRecord::Base
  attr_accessor :login
  attr_reader :avatar_remote_url

  # Order is important. Don't change it unless...
  ROLES = %w[user moderator admin]

  devise :database_authenticatable,
         :omniauthable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :topics,        dependent: :destroy
  has_many :replies,       dependent: :destroy
  has_many :notifications, dependent: :destroy, class_name: 'Notification::Base'

  has_attached_file :avatar, styles: { normal: '40x40>', thumb: '22x22>' },
                             path:   ':rails_root/public/uploads/assets/users/:id/:style/:filename',
                             url:    '/uploads/assets/users/:id/:style/:filename'

  # Role
  validates :role, presence: true,
                   inclusion: { in: ROLES }

  # Username
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[A-Za-z_\d]+\Z/ },
                       length: { maximum: 17 }

  # Avatar
  validates_attachment_content_type :avatar, content_type: ['image/png', 'image/jpeg']
  validates_attachment_size :avatar,
                            less_than: 500.kilobytes,
                            message: 'must less than 500KB'

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

  TOPICS_NUM = 10
  REPLIES_NUM = 10

  def latest_topics
    topics.order("created_at DESC").limit(TOPICS_NUM)
  end

  def latest_replies
    replies.order("created_at DESC").limit(REPLIES_NUM)
  end

  def more_topics?
    topics.count > TOPICS_NUM
  end

  def more_replies?
    replies.count > REPLIES_NUM
  end

  def star_topic(topic_id)
    return if stars.include?(topic_id)
    stars_will_change!
    update_attributes(stars: stars << topic_id)
  end

  def unstar_topic(topic_id)
    return unless stars.include?(topic_id)
    stars_will_change!
    update_attributes(stars: stars - [topic_id])
  end

  def new_notification?
    notifications.unread.any?
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

  def role?(base_role)
    # use compare to make pemission inherit
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def avatar_remote_url=(url)
    self.avatar = URI.parse(url)
    @avatar_remote_url = url
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
