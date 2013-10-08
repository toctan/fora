class Node < ActiveRecord::Base
  has_many :topics, dependent: :destroy

  validates :name, presence: true
  validates :key,  presence: true,
                   uniqueness: { case_sensitive: false }

  def self.more?
    Node.count > limit
  end

  def self.limit
    10
  end
end
