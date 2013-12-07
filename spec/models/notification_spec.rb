require 'spec_helper'

describe Notification do
  it { should belong_to(:target) }
  it { should belong_to(:source) }
  it { should belong_to(:reply) }
  it { should belong_to(:topic) }

  it { should validate_presence_of(:target_id) }
  it { should validate_presence_of(:source_id) }
  it { should validate_presence_of(:topic_id) }
  it { should validate_presence_of(:kind) }

  it { should have_db_index(:target_id) }
  it { should have_db_index(:is_read) }
end
