require 'test_helper'

class DaysControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get days_create_url
    assert_response :success
  end

  test "should get update" do
    get days_update_url
    assert_response :success
  end

end
