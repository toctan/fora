class TopicList
  # TODO: fetch all the nodes in one query
  def self.list(page)
    Topic.page(page).tap do |topics|
      users = UsersFetcher.new(topics.map(&:participant_ids))

      topics.each do |t|
        t.participants users
      end
    end
  end
end
