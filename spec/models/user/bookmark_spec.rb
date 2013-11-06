require 'spec_helper'

describe User::Bookmark do
  class DummyUser
    include User::Bookmark

    attr_accessor :bookmarks

    def initialize
      @bookmarks = []
    end

    def bookmarks_will_change!; end

    def save!; end
  end

  subject(:user) { DummyUser.new }

  describe '#bookmarked?' do
    it 'returns false when the topic is not bookmarked' do
      result = user.bookmarked? 1
      expect(result).to be_false
    end

    it 'returns true when the topic is bookmarked' do
      user.bookmarks = [1]
      result = user.bookmarked? 1
      expect(result).to be_true
    end
  end

  describe '#bookmark_or_unbookmark' do
    it 'bookmarks the topic when it is not bookmarked' do
      user.bookmark_or_unbookmark 1
      expect(user.bookmarks).to eq [1]
    end

    it 'unbookmarks the topic when it is bookmarked' do
      user.bookmarks = [1]
      user.bookmark_or_unbookmark 1
      expect(user.bookmarks).to eq []
    end
  end
end
