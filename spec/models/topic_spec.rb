require 'spec_helper'

describe Topic do
  it_behaves_like Mentionable

  it { should respond_to(:replies_count) }

  it { should have_many(:replies).dependent(:destroy) }

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:node_id) }
  it { should validate_presence_of(:title) }

  it { should ensure_length_of(:title).is_at_most(100) }

  it { should belong_to(:user) }
  it { should belong_to(:node) }

  it { should have_db_index(:node_id) }
  it { should have_db_index(:user_id) }

  it 'should update node topics_count' do
    node = create(:node)

    expect { create(:topic, node: node) }
      .to change { node.reload.topics_count }.by(1)
  end

  it 'should update user topics_count' do
    user = create(:user)

    expect { create(:topic, user: user) }
      .to change { user.reload.topics_count }.by(1)
  end

  describe '#participant_ids' do
    let(:topic) do
      Topic.new(
        user_id: 1,
        active_replier_ids: [4, 3, 5, 6],
        last_replier_id: 2
        )
    end

    it 'returns the ids in proper order' do
      expect(topic.participant_ids).to eq [1, 2, 4, 3, 5, 6]
    end
  end

  describe '#new_reply' do
    let(:topic) { create(:topic) }
    let(:user) { User.last }

    it 'saves the reply' do
      expect { topic.new_reply(user.id, attributes_for(:reply)) }
        .to change { Reply.count }.by(1)
    end

    it 'updates last_replier_id' do
      topic.new_reply(user.id, attributes_for(:reply))

      expect(topic.reload.last_replier_id).to eq user.id
    end

    describe 'active repliers' do
      let(:users) { create_list(:user, 5) }
      let(:replier) { users.last }

      before do
        users.each do |u|
          create_list(:reply, 2, topic: topic, user: u)
        end
      end

      it 'updates active replier ids' do
        topic.new_reply(replier.id, attributes_for(:reply))

        expect(topic.reload.active_replier_ids)
          .to eq [replier.id, *users[1..3].reverse.map(&:id)]
      end
    end
  end
end
