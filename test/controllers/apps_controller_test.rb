require "test_helper"

class AppsControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "index should be succesfull" do

    server = servers(:example)

    get :index, params: { server_id: server }

    assert_response :success
  end

  test "Show should be succesfull" do
    app = apps(:example)

    get :show, params: { server_id: app.server, id: app }

    assert_response :success
  end

  test "Redirects to ServerUpdatingPath if server is busy updating" do
    server = servers(:example).tap { |s| s.update(updating: true) }

    get :index, params: { server_id: server }

    assert_response :redirect
  end
end
