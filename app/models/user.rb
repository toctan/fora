class User < ActiveRecord::Base
  attr_accessor :login, :avatar
  has_attached_file :avatar, :styles => { medium: "300x300>", thumb: "20x20>"},
                    :path => ":rails_root/public/assets/users/:id/:style/:filename",
                    :url => "/assets/users/:id/:style/:filename"

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :topics, dependent: :destroy

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       format: { with: /\A[A-Za-z\d]+\Z/ },
                       length: { maximum: 17 }

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
