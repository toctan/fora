class Node < ActiveRecord::Base
  attr_reader :image_remote_url

  has_many :topics, dependent: :destroy

  has_attached_file :image, styles: { medium: '300x200>' }

  validates_attachment :image, content_type: { content_type: /^image\/(jpg|jpeg|png)$/ },
                               size: { less_than: 2.megabytes }

  validates :name, presence: true
  validates :key,  presence: true,
                   uniqueness: { case_sensitive: false },
                   format: { with: /\A[-A-Za-z\d]+\z/ }

  validates :description, length: { maximum: 140 }

  def image_remote_url=(url)
    self.image = URI.parse(url)
    @avatar_remote_url = url
  end
end

# == Schema Information
#
# Table name: nodes
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  key                :string(255)
#  description        :string(255)
#  topics_count       :integer          default(0)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_nodes_on_key  (key) UNIQUE
#
