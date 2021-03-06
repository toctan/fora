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

  describe 'Notifications' do
    subject(:user) { build_stubbed(:user) }

    before { create_list(:notification, 3, target: user) }

    it { expect(user.unread_notifications_count).to eq(3) }

    describe '#read_notifications' do
      it 'should mark all new notifications as read' do
        expect { user.read_notifications }.to change {
          user.notifications.unread.count
        }.from(3).to(0)
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
