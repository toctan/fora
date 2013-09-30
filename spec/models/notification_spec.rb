require 'spec_helper'

describe Notification::Base do
  it { should belong_to(:user) }

  it { should have_db_index(:user_id) }
  it { should have_db_index(:reply_id) }
  it { should have_db_index(:is_read) }
  it { should have_db_index([:mentionable_id, :mentionable_type]) }
end

describe Notification::Mention do
  it { should belong_to(:mentionable) }
end

describe Notification::TopicReply do
  it { should belong_to(:reply) }
end
