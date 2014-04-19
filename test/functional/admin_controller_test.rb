require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get statistics" do
    get :statistics
    assert_response :success
  end

end
