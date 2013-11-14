module ApplicationHelper
  def nav_link(key, path)
    klass = 'active' if body_class.include? "#{key}-index"
    link_to t(key), path, class: klass
  end

  def timeago(time, options = {})
    return unless time
    options[:class] ||= 'js-timeago'
    content_tag(:time, time.to_s, options.merge(datetime: time.getutc.iso8601))
  end
end
