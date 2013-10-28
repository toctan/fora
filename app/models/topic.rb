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

  self.per_page = 20

  # TODO: It takes about 30ms to finish, maybe using redis counter?
  def update_hits
    Topic.where(id: id).update_all 'hits = hits + 1'
  end

  def participants(users = nil)
    @participants ||= TopicParticipants.new(self, users: users).participants
  end

  def participant_ids
    [user_id, last_replier_id, *active_replier_ids]
  end

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

  # TODO: This should be done in background job
  def update_replier(replier_id)
    active_replier_ids =
      Reply.select('COUNT(id) as replies_count',
      'user_id', 'MAX(updated_at) AS updated_at')
      .where("topic_id = ? and user_id <> ?", id, user_id)
      .group(:user_id).order('replies_count desc', 'updated_at desc')
      .limit(4).map(&:user_id)

    update(
      last_replier_id: replier_id,
      active_replier_ids: active_replier_ids
      )
  end

  def mention_scan_text
    "#{body} #{title}"
  end
end
