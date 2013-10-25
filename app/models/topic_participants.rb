class TopicParticipants
  extend Forwardable
  def_delegator :@topic, :participant_ids

  attr_reader :options

  def initialize(topic, options = {})
    @topic = topic
    @options = options
  end

  def participants
    @participants ||= participant_id_with_desc_keys.map { |idkey|
      set_description_for_participants(users[idkey[0]], idkey[1]) if idkey[0]
    }.compact.uniq.take(5).tap do |ps|
      last_replier = ps.delete_at(1)
      ps.push(last_replier) if last_replier
    end
  end

  private

  def participant_id_with_desc_keys
    participant_ids.zip [
      :topic_author,
      :last_replier,
      :most_replies,
      :active_replier,
      :active_replier,
      :active_replier
    ]
  end

  def set_description_for_participants(user, desc_key)
    user.tap do |u|
      u.description ||= []
      u.description << I18n.t(desc_key)
    end
  end

  def users
    @users ||= options[:users] || UsersFetcher.new(participant_ids)
  end
end
