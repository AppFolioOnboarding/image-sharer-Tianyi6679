class ImageMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def welcome_email(request)
    @img = request[:image]
    @email = request[:email]
    @msg = request[:message]
    @url = 'https://image-sharer-mailaction-ysoft0.herokuapp.com/'
    mail(to: @email, subject: 'Welcome to My Awesome Image Sharer')
  end
end
