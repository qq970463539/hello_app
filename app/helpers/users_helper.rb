module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    size = options[:size]
    email_hash = Digest::MD5::hexdigest(user.email.downcase)
    url = "https://secure.gravatar.com/avatar/#{email_hash}?s=#{size}"

    image_tag url,
              alt: user.name,
              class: "rounded-circle shadow #{options[:class]}"
  end
end