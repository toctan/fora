class User < ActiveRecord::Base
  attr_accessor :login

  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :topics, dependent: :destroy
  has_many :replies

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
