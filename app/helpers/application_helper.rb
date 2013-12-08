module ApplicationHelper
  def breadcrumbs(*crumbs)
    content_tag :ol, class: 'nav breadcrumb body-text' do
      result = []
      result << content_tag(:li, link_to(t('site.name'), root_path))
      crumbs.each do |crumb|
        result << content_tag(:li, crumb)
      end
      raw result.join('')
    end
  end

  def nav_link(key, path)
    klass = 'active' if body_class.include? "#{key}-index"
    link_to t(key), path, class: klass
  end

  def timeago(time, options = {})
    return unless time
    options[:class] ||= 'js-timeago'
    content_tag(:time, time.to_s, options.merge(datetime: time.getutc.iso8601))
  end

  def icon(name)
    content_tag :i, nil, class: "icon icon-#{name}"
  end
end
