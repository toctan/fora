class User < ActiveRecord::Base
  attr_accessor :login, :avatar

  # Order is important. Don't change it unless carefully
  ROLES = %w[user moderator admin]

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :topics,  dependent: :destroy
  has_many :replies, dependent: :destroy

  has_attached_file :avatar, :styles => { normal: "40x40>", thumb: "22x22>"},
                    :path => ":rails_root/public/uploads/assets/users/:id/:style/:filename",
                    :url => "/uploads/assets/users/:id/:style/:filename"

  # Role
  validates :role, presence: true,
                   inclusion: { in: ROLES }

  # Username
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[A-Za-z\d]+\Z/ },
                       length: { maximum: 17 }

  # Avatar
  validates_attachment_content_type :avatar, content_type: ['image/png', 'image/jpeg']
  validates_attachment_size :avatar,
                            less_than: 500.kilobytes,
                            message: 'must less than 500KB'

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

  def update_with_password(params={})
    if !params[:current_password].blank? or !params[:password].blank? or
        !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
  end

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  protected

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where([
        "lower(username) = :value OR lower(email) = :value",
        { :value => login.downcase }
        ]).first
    else
      where(conditions).first
    end
  end
end
