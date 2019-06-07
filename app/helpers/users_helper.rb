# frozen_string_literal: true

module UsersHelper
  def gravatar_for(user)
    gravatar_url = 'http://s3.amazonaws.com/37assets/svn/765-default-avatar.png'
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end
end
