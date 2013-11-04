require 'spec_helper'

describe User do
  it { should have_db_index([:provider, :uid]).unique(true) }

  it { should have_many(:topics).dependent(:destroy) }
  it { should have_many(:replies).dependent(:destroy) }

  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should ensure_length_of(:username).is_at_most(17) }

  it { should allow_value('foo_bar').for(:username) }
  it { should_not allow_value('@foo').for(:username) }

  it { should validate_uniqueness_of(:username).case_insensitive }
  it { should allow_value('foo+bar@example.com').for(:email) }
  it { should_not allow_value('foo;@example.com').for(:email) }

  describe 'Notifications' do
    subject(:user) { build(:user) }

    before { create_list(:notification_mention, 3, user: user) }

    it { expect(user.new_notification?).to be_true }

    describe '#read_notifications' do
      it 'should mark all new notifications as read' do
        expect { user.read_notifications }.to change {
          user.notifications.unread.count
        }.from(3).to(0)

        expect(user.new_notification?).to be_false
      end
    end

    describe '#clear_notifications' do
      it 'should delete all the notifications' do
        expect { user.clear_notifications }.to change {
          user.notifications.count
        }.from(3).to(0)
      end
    end
  end
end
