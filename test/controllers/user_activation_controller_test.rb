require "test_helper"

class UserActivationControllerTest < ActionController::TestCase
  test "GET edit should be successfull" do
    user = users(:jane)
    get :edit, id: user.activation_token

    assert_response :success
  end

  test "PATCH update should be successfull" do
    user = users(:jane)
    patch :update, id: user.activation_token, user: { password: "secret_password" }

    assert_response :redirect
  end
end
