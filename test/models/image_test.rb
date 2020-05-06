require 'test_helper'

class ImageTest < ActiveSupport::TestCase
  test 'invalid input warning' do
    new_image = Image.new(
      title: '<3',
      url: 'invalid url'
    )

    assert_not new_image.valid?
    assert_equal ['is too short (minimum is 3 characters)'], new_image.errors.messages[:title]
    assert_equal ['Please enter a valid URL'], new_image.errors.messages[:url]
  end

  test 'valid input' do
    new_image = Image.new(
      title: '>=3',
      url: 'https://img.webmd.com/dtmcms/live/webmd/consumer_assets/site_images/article_thumbnails/other/cat_weight_other/1800x1200_cat_weight_other.jpg'
    )

    assert new_image.valid?
    assert_equal [], new_image.errors.messages[:title]
    assert_equal [], new_image.errors.messages[:url]
  end
end
