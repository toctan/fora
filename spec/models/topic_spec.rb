require 'spec_helper'

describe Topic do
  it { should respond_to(:user) }
  it { should respond_to(:replies) }
  it { should respond_to(:replies_count) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:node_id) }
  it { should validate_presence_of(:title) }

  it { should ensure_length_of(:title).is_at_most(100) }
end
