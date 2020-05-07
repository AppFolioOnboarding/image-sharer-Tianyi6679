require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'landing page' do
    get root_path
    assert_equal 'index', @controller.action_name
    assert_response :success
    assert_select 'h1', "Welcome to Tim's Image Sharer"
  end
end
