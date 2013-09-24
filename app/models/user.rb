class User < ActiveRecord::Base
  attr_accessor :login, :avatar

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :topics, dependent: :destroy

  has_attached_file :avatar, :styles => { medium: "300x300>", thumb: "20x20>"},
                    :path => ":rails_root/public/uploads/assets/users/:id/:style/:filename",
                    :url => "/uploads/assets/users/:id/:style/:filename"

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[A-Za-z\d]+\Z/ },
                       length: { maximum: 17 }

  validates_attachment_content_type :avatar, content_type: ['image/png', 'image/jpeg']
  validates_attachment_size :avatar,
                            less_than: 500.kilobytes,
                            message: 'must less than 500KB'

  before_save :email_nomarlization

  def update_with_password(params={})
    if !params[:current_password].blank? or !params[:password].blank? or
        !params[:password_confirmation].blank?
      super
    else
      params.delete(:current_password)
      self.update_without_password(params)
    end
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

  private

  def email_nomarlization
    self.email = email.strip.downcase
  end
end
