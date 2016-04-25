require "test_helper"

class ServerLoadReadingsControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "GET index should be successfull" do
    get :index, params: { server_id: servers(:example) }
    assert_response :success
  end
end
