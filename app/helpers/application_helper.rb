module ApplicationHelper
  def content_for_title(text)
    content_for :title, text
  end

  def title(text, options = {})
    options.reverse_merge!(action: :prepend)

    result = text
    if options[:add].present?
      add = options[:add].to_a.reject{ |k, v| v.nil? }
      if add.present?
        add = add.map{ |k, v| "#{k} #{v}" }.join(", ")
        result = "#{result} (#{add})"
      end
    end
    result = case options[:action]
      when :prepend
        "#{result} • Taskie"
      when :clear
        result
      else
        raise ArgumentError, ":action doesn't accept #{options[:action].inspect}"
      end

    content_for_title result
  end

  def gravatar_for(user, options = {})
    size = options[:size] || 20
    image = image_tag("https://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{size}", style: "width: #{size}px", alt: "G")
    unless user_signed_in? and current_user.id == user.id
      image
    else
      link_to image, "http://gravatar.com", target: "_blank"
    end
  end

  def user_with_gravatar(user_or_id, options = {})
    user = user_or_id.is_a?(Integer) ? User.find(user_or_id) : user_or_id
    if user.present?
      content_tag :span, class: "gravatar" do
        gravatar_for(user, size: 16) + user.username
      end
    else
      options.reverse_merge!(alt: "nobody")
      options[:alt]
    end
  end

  def render_markdown(text)
    if text.present?
      @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true)
      @markdown.render(text).html_safe
    end
  end

  # http://andre.arko.net/2013/02/02/nested-layouts-on-rails--31/
  def inside_layout(parent_layout)
    view_flow.set :layout, capture { yield }
    render template: "layouts/#{parent_layout}"
  end
end
