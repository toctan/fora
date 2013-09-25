require 'spec_helper'

describe Reply do
  it { should respond_to(:body) }
  it { should respond_to(:user) }
  it { should respond_to(:topic) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:topic_id) }
  it { should validate_presence_of(:body) }
end
