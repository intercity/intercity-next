require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "GET new should be successfull" do
    get :new
    assert_response :success
  end

  test "POST create should create a new server and then redirect to that server" do
    assert_difference "Server.count" do
      post :create, params: { server: { name: "test-server", ip: "127.0.0.1" } }
    end
    assert_response :redirect
  end
end
