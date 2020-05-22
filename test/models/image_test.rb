require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'invalid input warning' do
    new_image = Image.new(
      title: '<5',
      url: 'invalid url'
    )

    assert_not new_image.valid?
    assert_equal ['is too short (minimum is 5 characters)'], new_image.errors.messages[:title]
    assert_equal ['is invalid'], new_image.errors.messages[:url]
    assert_equal ["can't be blank"], new_image.errors.messages[:tag_list]
  end

  test 'valid input' do
    new_image = Image.new(
      title: '>=555',
      url: 'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_weight_other/1800x1200_cat_weight_other.jpg',
      tag_list: 'tag1, tag2'
    )

    assert new_image.valid?
  end
end
