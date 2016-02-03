module ApplicationHelper
  def content_for_title(text)
    content_for :title, text
  end

  def title(text, options = {})
    options.reverse_merge!(action: :prepend)

    result = text
    if options[:add].present?
      add = options[:add].to_a.reject { |_k, v| v.nil? }
      if add.present?
        add = add.map { |k, v| "#{k} #{v}" }.join(", ")
        result = "#{result} (#{add})"
      end
    end
    result =
      case options[:action]
      when :prepend
        "#{result} | Taskie"
      when :clear
        result
      else
        fail ArgumentError, ":action doesn't accept #{options[:action].inspect}"
      end

    content_for_title result
  end

  def gravatar_for(user, options = {})
    size = options[:size] || 20
    image = image_tag(
      "https://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{size}",
      style: "width: #{size}px",
      alt: "G"
    )

    if user_signed_in? && current_user.id == user.id
      link_to image, 'http://gravatar.com', target: '_blank'
    else
      image
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

  def markdown_renderer
    @_markdown_renderer ||=
      Redcarpet::Markdown.new(
        Redcarpet::Render::HTML,
        autolink: true,
        space_after_headers: true
      )
  end

  def render_markdown(text)
    return unless text.present?

    markdown_renderer.render(text).html_safe
  end

  # http://andre.arko.net/2013/02/02/nested-layouts-on-rails--31/
  def inside_layout(parent_layout)
    view_flow.set :layout, capture { yield }
    render template: "layouts/#{parent_layout}"
  end
end
