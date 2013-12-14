# Stolen from seyhunak/twitter-bootstrap-rails
module BootstrapHelper
  ALERT_TYPES = [:error, :info, :success, :warning]

  def bootstrap_flash
    flash_messages = []
    flash.each do |type, message|
      next if message.blank?
      type = :success if type == :notice
      type = :error if type == :alert
      next unless ALERT_TYPES.include?(type)

      Array(message).each do |msg|
        text = content_tag(:div, content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") + msg.html_safe, :class => "alert fade in alert-#{type}")
        flash_messages << text if msg
      end
    end
    flash_messages.join("\n").html_safe
  end

  def menu_item(name=nil, path="#", *args, &block)
    path = name || path if block_given?
    options = args.extract_options!
    content_tag :li, class: is_active?(path, options) do
      name, path = path, options if block_given?
      link_to name, path, options, &block
    end
  end

  def uri_state(uri, options={})
    root_url = request.host_with_port + '/'
    root = uri == '/' || uri == root_url

    request_uri = if uri.start_with?(root_url)
      request.url
    else
      request.path
    end

    if !options[:method].nil? || !options["data-method"].nil?
      :inactive
    elsif uri == request_uri || (options[:root] && (request_uri == '/') || (request_uri == root_url))
      :active
    else
      if request_uri.start_with?(uri) and not(root)
        :chosen
      else
        :inactive
      end
    end
  end

  private

  def is_active?(path, options={})
    "active" if uri_state(path, options).in?([:active, :chosen])
  end
end
