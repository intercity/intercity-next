require "test_helper"

class ServicesControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "GET index should be successfull" do
    get :index, params: { server_id: servers(:example) }
    assert_response :success
  end

  test "POST create should create a new service for the given server" do
    server = servers(:local)
    service = services(:redis)

    assert_difference "server.reload.services.count" do
      post :create, params: { server_id: server, id: service }
    end
  end
end
