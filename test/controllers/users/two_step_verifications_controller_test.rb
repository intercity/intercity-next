require "test_helper"

class Users::TwoStepVerificationsControllerTest < ActionController::TestCase
  test "GET new should be successful" do
    login_user users(:john)

    get :new

    assert_response :success
  end

  test "POST create should enable 2fa if code is valid" do
    login_user users(:john)

    ROTP::TOTP.any_instance.stubs(:verify).returns(true)

    post :create, params: { two_factor_auth: { code: "123" } }
    assert_response :redirect
    assert users(:john).reload.two_factor_auth_enabled?, "2fa should be enabled"
  end

  test "DELETE destroy should disable 2fa if code is valid" do
    user = users(:john).tap { |u| u.update!(two_factor_auth_enabled: true) }
    session[:passed_two_factor_auth] = true

    login_user user

    ROTP::TOTP.any_instance.stubs(:verify).returns(true)

    post :destroy, params: { two_factor_auth: { code: "123" } }
    assert_response :redirect
    refute users(:john).reload.two_factor_auth_enabled?, "2fa should be disabled"
  end
end
