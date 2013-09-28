require 'spec_helper'

describe Reply do
  subject(:reply) { build(:reply) }

  it { should respond_to(:body) }
  it { should respond_to(:user) }
  it { should respond_to(:topic) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:topic_id) }
  it { should validate_presence_of(:body) }

  describe '#send_notifications' do
    let(:user) { reply.user }

    context 'when the replier is not the topic creator' do
      it 'should notify topic creator after create' do
        expect(user).to receive(:notify)
        reply.save
      end
    end

    context 'when the replier is the topic creator' do
      before { reply.user = reply.topic.user }

      it 'should not notify the topic creator' do
        expect(user).not_to receive(:notify)
        reply.save
      end
    end
  end
end
