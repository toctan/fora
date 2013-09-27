class Reply < ActiveRecord::Base
  belongs_to :topic, counter_cache: true, touch: true
  belongs_to :user, counter_cache: true

  validates_presence_of :body, :topic_id, :user_id

  default_scope -> { order('updated_at DESC') }

  self.per_page = 20
end
