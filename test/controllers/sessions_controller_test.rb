require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "GET new should be successfull" do
    get login_path
    assert_response :success
  end

  test "POST create should be redirect when user exist" do
    post login_path, params: { login: { email: "john@example.com",
                                        password: "secret" } }
    assert_response :redirect
    refute_nil session["user_id"]
  end

  test "POST create should re-render when information is invalid" do
    post login_path, params: { login: { email: "john@example.com",
                                        password: "invalid-secret" } }
    assert_response :success
    assert_nil session["user_id"]
  end

  test "POST create should re-render when access token present" do
    user = users(:john)
    user.generate_activation_token
    user.skip_password_validation = true
    user.save!
    post login_path, params: { login: { email: "john@example.com",
                                        password: "secret" }}
    assert_response :success
  end

  test "DELETE destroy session should redirect to login path" do
    login_as users(:john)
    delete logout_path
    assert_response :redirect
    assert_nil session["user_id"]
  end
end
