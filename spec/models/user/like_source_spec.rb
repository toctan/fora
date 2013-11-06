require 'spec_helper'

describe User::LikeSource do
  describe '#likes?' do
    subject(:user) { User.new }
    let(:target) { double(id: 1) }

    it 'returns false when the user has not liked target' do
      expect(user.likes? target).to be_false
    end

    it 'returns true when the user likes the target' do
      user.stub_chain(:likes, :where).and_return([target])

      expect(user.likes? target).to be_true
    end
  end

  describe '#like_or_dislike' do
    subject(:user) { create(:user) }
    let(:target) { create(:topic) }

    it 'dislikes target when user have liked the topic' do
      Like.create(user: user, likeable: target)

      expect { user.like_or_dislike target }.to change(user.likes, :count).by(-1)
    end

    it 'likes the target when it have not been liked' do
      expect { user.like_or_dislike target }.to change(user.likes, :count).by(1)
    end
  end
end
