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

# == Schema Information
#
# Table name: nodes
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  key          :string(255)
#  description  :string(255)
#  topics_count :integer          default(0)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_nodes_on_key  (key) UNIQUE
#

