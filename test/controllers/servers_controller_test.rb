require 'test_helper'

class ServersControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "POST create should create a new server and then redirect to that server" do
    assert_difference "Server.count" do
      post :create, xhr: true, params: { server: { name: "test-server", ip: "127.0.0.1" } }
    end
    assert_response :success
  end
end
