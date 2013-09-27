require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.build(:user) }

  it { should respond_to(:topics) }
  it { should respond_to(:replies) }
  it { should respond_to(:stars) }

  it { should respond_to(:replies_count) }
  it { should respond_to(:topics_count) }

  it { should respond_to(:username) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should ensure_length_of(:username).is_at_most(17) }

  describe "when username's format is invalid" do
    before { user.username = "@#123" }

    it { should_not be_valid }
  end
end
