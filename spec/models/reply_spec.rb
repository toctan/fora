require 'spec_helper'

describe Reply do
  it { should respond_to(:body) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:topic_id) }
  it { should validate_presence_of(:body) }

  it { should validate_numericality_of(:user_id) }
  it { should validate_numericality_of(:topic_id) }

  it { should belong_to(:user) }
  it { should belong_to(:topic).touch }

  it { should have_db_index(:topic_id) }
  it { should have_db_index(:user_id) }

  it "should update topic replies_count" do
    topic = create(:topic)

    expect do
      reply = create(:reply, topic: topic)
      topic.reload
    end.to change{topic.replies_count}.by(1)

  end

  it "should update user replies_count" do
    user = create(:user)

    expect do
      reply = create(:reply, user: user)
      user.reload
    end.to change{user.replies_count}.by(1)

  end
end
