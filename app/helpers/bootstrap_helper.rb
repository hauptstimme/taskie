# Stolen from seyhunak/twitter-bootstrap-rails and updated

module BootstrapHelper
  ALERT_TYPES = {
    alert: :danger,
    info: :info,
    notice: :success,
    warning: :warning
  }.freeze

  def bootstrap_flash
    flash.flat_map do |type, message|
      next unless message.present? && ALERT_TYPES.keys.include?(type)

      Array(message).map do |msg|
        next unless msg.present?
        content_tag(
          :div,
          content_tag(:button, raw("&times;"), class: "close", data: { dismiss: "alert" }) + msg.html_safe,
          class: ['alert', 'fade', 'in', "alert-#{ALERT_TYPES[type]}"]
        )
      end
    end.compact.join("\n").html_safe
  end

  def menu_item(name = nil, path = "#", *args, &block)
    path = name || path if block_given?
    options = args.extract_options!
    content_tag :li, class: state_class_for(path, options) do
      name, path = path, options if block_given?
      link_to name, path, options, &block
    end
  end

  def uri_state(uri, options = {})
    root_url = request.host_with_port + '/'

    request_uri =
      if uri.start_with?(root_url)
        request.url
      else
        request.path
      end

    if !options[:method].nil? || !options['data-method'].nil?
      :inactive
    elsif request_uri == uri || options[:root] && (request_uri == '/') || request_uri == root_url
      :active
    elsif request_uri.start_with?(uri) && !['/', root_url].include?(uri)
      :chosen
    else
      :inactive
    end
  end

  private

  def state_class_for(path, options = {})
    'active' if uri_state(path, options).in?([:active, :chosen])
  end
end
