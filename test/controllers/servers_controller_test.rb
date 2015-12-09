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

  test "POST create should create a new server and then redirect to that server" do
    assert_difference "Server.count" do
      post :create, server: { name: "test-server", ip: "127.0.0.1" }
    end
    assert_response :redirect
  end
end
