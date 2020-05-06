require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test 'get welcome#index' do
    get welcome_index_path
    assert_equal 'index', @controller.action_name
    assert_response :success
    assert_match 'Welcome', @response.body
  end
end
