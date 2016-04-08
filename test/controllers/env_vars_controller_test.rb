require "test_helper"

class EnvVarsControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "GET index should be successfull" do
    app = apps(:example)

    get :index, params: { server_id: app.server, app_id: app.id }

    assert_response :success
  end

  test "POST create should create a new env var" do
    app = apps(:example)

    assert_difference "app.env_vars.count" do
      AddEnvVarJob.expects(:perform_later)
      post :create, xhr: true, params: { server_id: app.server, app_id: app.id,
        env_var: { key: "example_key", value: "example_value" } }
    end

    assert_response :success
  end

  test "DELETE destroy should remove an env var" do
    app = apps(:example)
    env_var = env_vars(:username)

    assert_difference "app.env_vars.count", -1 do
      DeleteEnvVarJob.expects(:perform_later)
      delete :destroy, xhr: true, params: { server_id: app.server, app_id: app,
                                            id: env_var }
    end
  end
end
