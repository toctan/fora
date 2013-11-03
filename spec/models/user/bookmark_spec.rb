require 'spec_helper'

describe User::Bookmark do
  subject(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }

  describe '#bookmarked?' do
    it 'returns false when the topic is not bookmarked' do
      result = user.bookmarked? topic.id
      expect(result).to eq false
    end

    it 'returns true when the topic is bookmarked' do
      user.update(bookmarks: [topic.id])
      result = user.reload.bookmarked? topic.id
      expect(result).to eq true
    end
  end

  describe '#bookmark_or_unbookmark' do
    it 'bookmarks the topic when it is not bookmarked' do
      user.bookmark_or_unbookmark topic.id
      expect(user.reload.bookmarks).to eq [topic.id]
    end

    it 'unbookmarks the topic when it is bookmarked' do
      user.update(bookmarks: [topic.id])
      user.bookmark_or_unbookmark topic.id
      expect(user.reload.bookmarks).to eq []
    end
  end
end
