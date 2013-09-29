class Topic < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :node, counter_cache: true

  has_many :replies, dependent: :destroy

  validates :title, presence: true,
                    length: { maximum: 100 }

  validates :user_id, presence: true, numericality: true
  validates :node_id, presence: true, numericality: true

  default_scope -> { order('updated_at DESC') }

  self.per_page = 20
end
