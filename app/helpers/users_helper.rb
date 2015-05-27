module UsersHelper
  def gravatar_id_for(user)
    Digest::MD5::hexdigest(user.email.downcase)
  end

  def gravatar_for(user, options = { size: 50 })
    gravatar_id = gravatar_id_for(user)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
    image_tag gravatar_url, alt: user.name, class: 'gravatar'
  end
end
