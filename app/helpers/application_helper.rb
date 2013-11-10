module ApplicationHelper
  def nav_link(key, path)
    klass = 'active' if body_class.include? "#{key}-index"
    link_to t(key), path, class: klass
  end

  def timestamp(time, options = {})
    options[:title] = l(time)
    content_tag(:time, time_ago_in_words(time), options)
  end
end
