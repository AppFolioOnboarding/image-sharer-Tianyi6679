require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
  test "root welcome#index" do
    get root_url
    assert_equal "index", @controller.action_name
    assert_response :success
    assert_match "Welcome", @response.body
  end
end
