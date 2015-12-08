require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "GET new should be successfull" do
    get :new
    assert_response :success
  end
end
