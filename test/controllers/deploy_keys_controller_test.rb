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
      CreateDeployKeyJob.expects(:perform_later)
      post :create, server_id: server,
        deploy_key: { name: "test_key", key: "data-test-key" }
    end

    assert_response :redirect
  end

  test "DESTROY should remove a given key" do
    server = servers(:example)
    deploy_key = deploy_keys(:admin)

    assert_difference "server.deploy_keys.count", -1 do
      DeleteDeployKeyJob.expects(:perform_later)
      delete :destroy, server_id: server, id: deploy_key
    end

    assert_response :redirect
  end
end
