class User
  module Bookmark
    def bookmark_or_unbookmark(topic_id)
      if bookmarked?(topic_id)
        unbookmark(topic_id)
      else
        bookmark(topic_id)
      end
    end

    def bookmarked?(topic_id)
      bookmarks.include? topic_id
    end

    private

    def bookmark(topic_id)
      bookmarks.push(topic_id).uniq
      bookmarks_will_change!
      save!
    end

    def unbookmark(topic_id)
      bookmarks.delete topic_id
      bookmarks_will_change!
      save!
    end
  end
end
