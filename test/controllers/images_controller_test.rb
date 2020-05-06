require 'test_helper'

class ImagesControllerTest < ActionDispatch::IntegrationTest
  test 'landing page' do
    get new_image_path
    assert_equal 'new', @controller.action_name
    assert_response :success
  end
end
