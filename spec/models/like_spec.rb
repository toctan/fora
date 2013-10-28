require 'spec_helper'

describe Like do
  it { should belong_to :user }
  it { should belong_to :likeable }

  it { should validate_presence_of :user_id }
  it { should validate_presence_of :likeable_id }
  it { should validate_presence_of :likeable_type }

  it { should have_db_index([:user_id, :likeable_id, :likeable_type]).unique(true) }
  it { should validate_uniqueness_of(:user_id).scoped_to(:likeable_id, :likeable_type) }
end
