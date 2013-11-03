module ApplicationHelper
  def gravatar_for user, options = {}
    size = options[:size] || 20
    image = image_tag("https://gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{size}", id: "gravatar", style: "width: #{size}px")
    unless user_signed_in? and current_user.id == user.id
      image
    else
      link_to image, "http://gravatar.com", target: "_blank"
    end
  end
end
