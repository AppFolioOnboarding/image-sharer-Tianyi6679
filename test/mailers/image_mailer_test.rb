require 'test_helper'

class ImageMailerTest < ActionMailer::TestCase
  test 'send_email' do
    request = {
      image: 'this is a valid url',
      message: '',
      email: 'email@example.com'
    }
    email = ImageMailer.welcome_email(request)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['notifications@example.com'], email.from
    assert_equal [request[:email]], email.to
    assert_equal 'Welcome to My Awesome Image Sharer', email.subject
  end
end
