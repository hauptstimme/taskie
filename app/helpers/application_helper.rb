module ApplicationHelper
  def gravatar_for user, options = {}
    hash = Digest::MD5.hexdigest(user.email)
    size = options[:size] || 20
    unless user_signed_in?
      image_tag("https://gravatar.com/avatar/#{hash}?s=#{size}", id: "gravatar")
    else
      link_to image_tag("https://gravatar.com/avatar/#{hash}?s=#{size}", id: "gravatar"), "http://gravatar.com", target: "_blank"
    end
  end
end
