class Topic < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :node, counter_cache: true

  has_many :replies, dependent: :destroy

  validates :title, presence: true,
                    length: { maximum: 100 }

  validates :user_id, presence: true
  validates :node_id, presence: true

  self.per_page = 20
end
