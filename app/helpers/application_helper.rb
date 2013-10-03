module ApplicationHelper
  def gravatar_for user, options = {}
    hash = Digest::MD5.hexdigest(user.email)
    size = options[:size] || 20
    image_tag("https://gravatar.com/avatar/#{hash}?s=#{size}", id: "gravatar")
  end
end
