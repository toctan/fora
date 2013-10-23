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

  delegate :username, to: :user

  default_scope -> { order('updated_at DESC') }

  self.per_page = 20

  def new_reply(replier_id, reply_params)
    replies.build(reply_params).tap do |reply|
      reply.user_id = replier_id
      update_replier(replier_id) if reply.save
    end
  end

  def topic
    self
  end

  private

  def mention_scan_text
    "#{body} #{title}"
  end

  def update_replier(replier_id)
    active_replier_ids = Reply.select('COUNT(id) as replies_count',
      'user_id', 'MAX(updated_at) AS updated_at')
      .where(topic_id: id).group(:user_id)
      .order('replies_count desc', 'updated_at desc')
      .limit(3).map(&:user_id)

    update(last_replier_id: replier_id,
      active_replier_ids: active_replier_ids)
  end
end
