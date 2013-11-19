module TopicsHelper
  def topic_title_tag(topic, reply_id = nil)
    return unless topic
    anchor = reply_id && "reply-#{reply_id}"
    link_to topic.title, topic_path(topic, anchor: anchor)
  end
end
