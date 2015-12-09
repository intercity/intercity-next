require "test_helper"

class SessionsControllerTest < ActionController::TestCase
  test "GET new should be successfull" do
    get :new
    assert_response :success
  end

  test "POST create should be redirect when user exist" do
    post :create, login: { email: "john@example.com",
                           password: "secret" }
    assert_response :redirect
    refute_nil session["user_id"]
  end

  test "POST create should re-render when information is invalid" do
    post :create, login: { email: "john@example.com",
                           password: "invalid-secret" }
    assert_response :success
  end

  test "DELETE destroy session should redirect to login path" do
    login_user users(:john)
    delete :destroy
    assert_response :redirect
    assert_nil session["user_id"]
  end
end
