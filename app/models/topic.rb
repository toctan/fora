class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :replies

  validates :title, presence: true,
                    length: { maximum: 100 }

  validates :user_id, presence: true

  self.per_page = 20
end
