require 'spec_helper'

describe Topic do
  it_behaves_like Mentionable

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:node_id) }

  it { should ensure_length_of(:title).is_at_most(100) }

  it { should have_many(:replies).dependent(:destroy) }
  it { should belong_to(:user).counter_cache }
  it { should belong_to(:node).counter_cache.touch }

  it { should have_db_index(:node_id) }
  it { should have_db_index(:user_id) }

  describe '#new_reply' do
    let(:topic) { create(:topic) }
    let(:user) { User.last }

    it 'saves the reply' do
      expect { topic.new_reply(user, attributes_for(:reply)) }
        .to change { Reply.count }.by(1)
    end

    it 'updates last_replier_username' do
      topic.new_reply(user, attributes_for(:reply))

      expect(topic.reload.last_replier_username).to eq user.username
    end
  end
end
