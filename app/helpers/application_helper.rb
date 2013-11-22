module ApplicationHelper
  def gravatar_for user, options = {}
    size = options[:size] || 20
    image = image_tag("https://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{size}", style: "width: #{size}px", alt: "G")
    unless user_signed_in? and current_user.id == user.id
      image
    else
      link_to image, "http://gravatar.com", target: "_blank"
    end
  end

  def user_with_gravatar user, options = {}
    if user.present?
      content_tag :span, class: "gravatar" do
        gravatar_for(user, size: 16) + user.username
      end
    else
      options.reverse_merge!(alt: "nobody")
      options[:alt]
    end
  end
end
