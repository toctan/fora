class Reply < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user

  validates_presence_of :body, :topic_id, :user_id

  self.per_page = 20
end
