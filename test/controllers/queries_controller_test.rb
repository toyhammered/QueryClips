require 'test_helper'

class QueriesControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get run" do
    get :run
    assert_response :success
  end

end
