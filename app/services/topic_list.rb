class TopicList
  def self.list(page)
    @topics ||= Topic.page(page).tap do |topics|
      users = UsersFetcher.new(topics.map(&:participant_ids))

      topics.each do |t|
        t.participants users
      end
    end
  end
end
