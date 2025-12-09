module UsersHelper
  def gravatar_for(user, size: 80)
    email_hash = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{email_hash}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar rounded-circle")
  end
end