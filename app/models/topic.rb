class Topic < ActiveRecord::Base
  include Redis::Objects
  include Mentionable
  include Likeable

  default_scope -> { order('updated_at DESC') }

  belongs_to :user, counter_cache: true
  belongs_to :node, counter_cache: true, touch: true

  has_many :replies, dependent: :destroy

  counter :hits

  validates :title, presence: true,
                    length: { maximum: 100 }

  validates :user_id, presence: true
  validates :node_id, presence: true

  delegate :username, to: :user

  self.per_page = 20

  def new_reply(replier, reply_params)
    replies.build(reply_params).tap do |reply|
      reply.user_id = replier.id
      update(last_replier_username: replier.username) if reply.save
    end
  end

  private

  def mention_scan_text
    "#{title} #{body}"
  end
end

# == Schema Information
#
# Table name: topics
#
#  id                    :integer          not null, primary key
#  title                 :string(255)      not null
#  body                  :text
#  likes_count           :integer          default(0)
#  replies_count         :integer          default(0)
#  last_replier_username :string(255)
#  user_id               :integer
#  node_id               :integer
#  created_at            :datetime
#  updated_at            :datetime
#
# Indexes
#
#  index_topics_on_node_id  (node_id)
#  index_topics_on_user_id  (user_id)
#
