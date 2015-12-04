require "test_helper"

class DeployKeysControllerTest < ActionController::TestCase
  test "GET index should be succesfull" do
    server = servers(:example)

    get :index, server_id: server

    assert_response :success
  end

  test "POST create should create a new key" do
    server = servers(:example)

    assert_difference "server.deploy_keys.count" do
      post :create, server_id: server,
        params: { name: "test_key", key: "data-test-key" }
    end

    assert_response :redirect
  end
end
