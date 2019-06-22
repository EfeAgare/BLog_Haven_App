# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = 'http://s3.amazonaws.com/37assets/svn/765-default-avatar.png'
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
