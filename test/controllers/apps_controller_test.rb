require "test_helper"

class AppsControllerTest < ActionController::TestCase
  test "index should be succesfull" do
    server = servers(:example)

    get :index, server_id: server

    assert_response :success
  end
end
