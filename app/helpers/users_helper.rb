module UsersHelper
  def gravatar_for(user, size: 80)
    email_hash = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{email_hash}?s=#{size}"
    image_tag url, alt: user.name, class: "rounded-circle shadow"
  end
end