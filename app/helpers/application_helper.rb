module ApplicationHelper
  def avatar_tag(user, opts = {})
    # TODO: method too long...
    link = opts.include?(:link) ? opts[:link] : true
    name = opts.include?(:name) ? opts[:name] : true
    size =  opts[:size] || :normal
    img_class  = opts[:img_class]
    link_class = opts[:link_class]

    img = avatar_img(user, size, img_class)

    img << user.username if name

    if link
      link_to img, user_path(username: user.username),  class: 'name #{link_class}'
    else
      img
    end
  end

  def font_icon(name, size = nil,  data = {})
    klass = "icon-#{name}"
    klass << " icon-#{size}" if size
    content_tag(:i, nil, class: klass, data: data, style: 'cursor:pointer')
  end

  private

  def user_avatar_width_for_size(size)
    case size
    when :thumb  then 22
    when :normal then 40
    when :large  then 64
    else size
    end
  end

  def avatar_img(user, size, img_class)
    width = user_avatar_width_for_size(size)
    img_src =
      if user.avatar?
        user.avatar.url(size)
      else
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{width}&d=identicon"
      end

    image_tag(img_src, class: "img-rounded #{img_class}")
  end

  def render_breadcrumb(node)
    content_tag(:ul, class: "breadcrumb") do
      content_tag(:li) do
        link_to('Home', root_path) +
        content_tag(:span, "/",class: "divider")
      end +
      content_tag(:li, "#{ node.key }", class: "active")
    end
  end

  def breadcrumb_with_create_button(node)
    link_to('Create new topic', "/new/#{ node.key }", class: 'btn btn-success btn-small pull-right mt5') +
    render_breadcrumb(node)
  end

  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type == :notice
      text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  def will_paginate(collection = nil, options = {})
    options[:renderer] ||= BootstrapLinkRenderer
    super.try :html_safe
  end

  class BootstrapLinkRenderer < WillPaginate::ActionView::LinkRenderer
    protected

    def html_container(html)
      tag :div, tag(:ul, html), container_attributes
    end

    def page_number(page)
      tag :li, link(page, page, :rel => rel_value(page)), :class => ('active' if page == current_page)
    end

    def previous_or_next_page(page, text, classname)
      tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('disabled' unless page)].join(' ')
    end

    def gap
      tag :li, link(super, '#'), :class => 'disabled'
    end
  end
end
