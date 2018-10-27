require 'test_helper'

module Overview
  class DaysControllerTest < ActionController::TestCase
    test '#index succeeds' do
      get :index
      assert_response :success
    end
  end
end