class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :likeable, polymorphic: true, counter_cache: true

  validates_presence_of :user_id, :likeable_id, :likeable_type
  validates_uniqueness_of :user_id, scope: [:likeable_id, :likeable_type]
end

# == Schema Information
#
# Table name: likes
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  likeable_id   :integer
#  likeable_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#
# Indexes
#
#  index_likes_on_likeable_id_and_likeable_type              (likeable_id,likeable_type)
#  index_likes_on_user_id                                    (user_id)
#  index_likes_on_user_id_and_likeable_id_and_likeable_type  (user_id,likeable_id,likeable_type) UNIQUE
#

