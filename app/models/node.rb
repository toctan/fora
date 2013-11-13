class Node < ActiveRecord::Base
  attr_reader :image_remote_url

  default_scope    -> { order('updated_at DESC') }
  scope :approved, -> { where(approved: true) }

  has_many :topics, dependent: :destroy
  belongs_to :user

  has_attached_file :image, styles: { medium: '300>' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpg|jpeg|png)$/ },
                               size: { less_than: 2.megabytes }

  validates :user_id, presence: true
  validates :name,    presence: true
  validates :key,     presence: true,
                      uniqueness: { case_sensitive: false },
                      format: { with: /\A[-A-Za-z\d]+\z/ }

  validates :description, length: { maximum: 140 }

  delegate :username, to: :user

  def image_remote_url=(url)
    self.image = URI.parse(url)
    @avatar_remote_url = url
  end

  def to_param
    key
  end
end

# == Schema Information
#
# Table name: nodes
#
#  id                 :integer          not null, primary key
#  name               :string(255)      not null
#  key                :string(255)      not null
#  color              :string(255)
#  description        :string(255)
#  topics_count       :integer          default(0)
#  approved           :boolean          default(FALSE), not null
#  user_id            :integer
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_nodes_on_approved  (approved)
#  index_nodes_on_key       (key) UNIQUE
#  index_nodes_on_user_id   (user_id)
#
