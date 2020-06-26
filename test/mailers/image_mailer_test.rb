require 'test_helper'

class ImageMailerTest < ActionMailer::TestCase
  test 'send_email' do
    email = {
      img: 'this is a valid url',
      msg: 'hello world!',
      to: 'email@example.com',
      home: 'this_is_my_welcome_page_url'
    }
    mailer = ImageMailer.welcome_email(email)

    assert_emails 1 do
      mailer.deliver_now
    end

    assert_equal ['notifications@example.com'], mailer.from
    assert_equal [email[:to]], mailer.to
    assert_equal 'Welcome to My Awesome Image Sharer', mailer.subject
    assert_equal read_fixture('welcome.html').join, mailer.html_part.body.to_s
    assert_equal read_fixture('welcome_text').join, mailer.text_part.body.to_s
  end
end
