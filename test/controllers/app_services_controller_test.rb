require "test_helper"

class AppServicesControllerTest < ActionController::TestCase
  test "GET index should be succesfull" do
    app = apps(:example)
    get :index, server_id: app.server, app_id: app

    assert_response :success
  end
end
