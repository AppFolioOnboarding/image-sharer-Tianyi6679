class ImageMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(email)
    @img = email[:img]
    @email = email[:to]
    @msg = email[:msg]
    @url = email[:home]
    mail(to: @email, subject: 'Welcome to My Awesome Image Sharer')
  end
end
