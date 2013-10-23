class User < ActiveRecord::Base
  attr_accessor :login
  attr_reader :avatar_remote_url

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

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[A-Za-z_\d]+\Z/ },
                       length: { maximum: 17 }

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
