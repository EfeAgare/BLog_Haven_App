# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'Author Haven <noreply@authorHeaven.com>'
  layout 'mailer'
end
