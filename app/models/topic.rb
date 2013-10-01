class Topic < ActiveRecord::Base
  include Mentionable
  include Autohtmlable

  belongs_to :user, counter_cache: true
  belongs_to :node, counter_cache: true

  has_many :replies, dependent: :destroy

  validates :title, presence: true,
                    length: { maximum: 100 }

  validates :user_id, presence: true
  validates :node_id, presence: true

  default_scope -> { order('updated_at DESC') }

  self.per_page = 20

  def topic
    self
  end

  private

  def mention_scan_text
    "#{body} #{title}"
  end
end
