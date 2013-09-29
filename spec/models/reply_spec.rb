require 'spec_helper'

describe Reply do
  it_behaves_like Mentionable

  subject(:reply) { build :reply }

  it { should respond_to(:body) }
  it { should respond_to(:user) }
  it { should respond_to(:topic) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:topic_id) }
  it { should validate_presence_of(:body) }

  describe '#after_create' do
    after(:each) { reply.save }

    context 'when the replier is not the topic starter' do
      it 'should send notification to topic starter' do
        expect(Notification::TopicReply).to receive(:create)
          .once.with(user: reply.topic.user, reply: reply)
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
