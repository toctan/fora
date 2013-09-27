class Node < ActiveRecord::Base
  has_many :topics, dependent: :destroy

  validates :name, presence: true
  validates :key,  presence: true
end
