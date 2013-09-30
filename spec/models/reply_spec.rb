require 'spec_helper'

describe Reply do
  it_behaves_like Mentionable

  subject(:reply) { build :reply }

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

  it 'should update topic replies_count' do
    topic = create(:topic)

    expect do
      create(:reply, topic: topic)
      topic.reload
    end.to change { topic.replies_count }.by(1)

  end

  it 'should update user replies_count' do
    user = create(:user)

    expect do
      create(:reply, user: user)
      user.reload
    end.to change { user.replies_count }.by(1)
  end

  describe '#after_create' do
    after(:each) { reply.save }

    context 'when the replier is not the topic starter' do

      it 'should send notification to topic starter' do
        expect(reply).to receive(:create_reply_notification)
          .once.with(user: reply.topic.user)
      end

      context 'when the replier mentions the topic starter in reply' do

        before { reply.body = "@#{reply.topic.user.username}"}

        it 'should not send mention notification' do
          expect(subject.notifications).not_to receive(:create)
            .with(user: reply.topic.user)
        end
      end
    end

    context 'when the replier is the topic starter' do
      before { reply.user = reply.topic.user }

      it 'should not send the notification' do
        expect(Notification::TopicReply).not_to receive(:create)
      end
    end
  end
end
