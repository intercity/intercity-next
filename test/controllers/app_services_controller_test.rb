require "test_helper"

class AppServicesControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "GET index should be succesfull" do
    app = apps(:example)
    get :index, params: { server_id: app.server, app_id: app }

    assert_response :success
  end

  test "Redirects to ServerUpdatingPath if server is busy updating" do
    server = servers(:example).tap { |s| s.update(updating: true) }
    app = apps(:example)

    get :index, params: { server_id: server, app_id: app }

    assert_response :redirect
  end
end
