require 'spec_helper'

describe User::LikeSource do
  subject(:user) { create(:user) }
  let!(:target) { create(:topic, user: user) }
  let(:likes_count) { -> { target.reload.likes_count } }

  describe '#like' do
    it 'increments the target likes_count' do
      expect { user.like target }.to change(&likes_count).by(1)
    end

    context 'when the user has liked the target' do
      before { user.like target }

      it 'should not increments the likes_count' do
        expect { user.like target }.to change(&likes_count).by(0)
      end
    end
  end

  describe '#dislike' do
    context 'when the user has liked the target' do
      before { user.like target }

      it 'decrements the target likes_count' do
        expect { user.dislike target }.to change(&likes_count).by(-1)
      end
    end

    context 'when the user has not liked the target' do
      it 'should not decrements the target likes_count' do
        expect { user.dislike target }.to change(&likes_count).by(0)
      end
    end
  end

  describe '#likes?' do
    it 'returns false when the user has not liked target' do
      expect(user.likes? target).to be_false
    end

    it 'returns true when the user likes the target' do
      user.like target

      expect(user.likes? target).to be_true
    end
  end
end
