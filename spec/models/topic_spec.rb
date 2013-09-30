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

    expect do
      create(:topic, node: node)
      node.reload
    end.to change { node.topics_count }.by(1)

  end

  it 'should update user topics_count' do
    user = create(:user)

    expect do
      create(:topic, user: user)
      user.reload
    end.to change { user.topics_count }.by(1)
  end
end
