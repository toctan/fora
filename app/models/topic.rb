class Topic < ActiveRecord::Base
  include Mentionable
  include Autohtmlable

  default_scope -> { order('updated_at DESC') }

  belongs_to :user, counter_cache: true
  belongs_to :node, counter_cache: true

  has_many :replies, dependent: :destroy

  validates :title, presence: true,
                    length: { maximum: 100 }

  validates :user_id, presence: true
  validates :node_id, presence: true

  delegate :username, to: :user
  delegate :name, to: :node, prefix: true

  self.per_page = 20

  def new_reply(replier, reply_params)
    replies.build(reply_params).tap do |reply|
      reply.user_id = replier.id
      update(last_replier_username: replier.username) if reply.save
    end
  end

  # TODO: It takes about 30ms to finish, maybe using redis counter?
  def update_hits
    Topic.where(id: id).update_all 'hits = hits + 1'
  end

  def topic
    self
  end

  private

  def mention_scan_text
    "#{body} #{title}"
  end
end

# == Schema Information
#
# Table name: topics
#
#  id                 :integer          not null, primary key
#  title              :string(255)
#  body               :text
#  body_html          :text
#  hits               :integer          default(0)
#  likes_count        :integer          default(0)
#  replies_count      :integer          default(0)
#  last_replier_id    :integer
#  user_id            :integer
#  node_id            :integer
#  active_replier_ids :integer          default([])
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_topics_on_node_id  (node_id)
#  index_topics_on_user_id  (user_id)
#
