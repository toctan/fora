require 'spec_helper'

describe User do
  subject(:user) { build(:user) }

  it { should respond_to(:topics) }
  it { should respond_to(:replies) }
  it { should respond_to(:stars) }

  it { should respond_to(:replies_count) }
  it { should respond_to(:topics_count) }

  it { should respond_to(:username) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username) }
  it { should ensure_length_of(:username).is_at_most(17) }

  describe 'when username\'s format is invalid' do
    before { user.username = '@#123' }

    it { should_not be_valid }
  end

  describe 'Notifications' do
    before { create_list(:notification_mention, 3, user: user) }

    it { expect(user.new_notification?).to be_true }

    describe '#read_notifications' do
      it 'should mark all new notifications as read' do
        expect { user.read_notifications }.to change { user
            .notifications.unread.count }.from(3).to(0)
        expect(user.new_notification?).to be_false
      end
    end

    describe '#clear_notifications' do
      it 'should delete all the notifications' do
        expect { user.clear_notifications }.to change { user
            .notifications.count }.from(3).to(0)
      end
    end
  end
end
