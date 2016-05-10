require "test_helper"

class TwoFactorAuthsControllerTest < ActionController::TestCase
  test "GET new should be successful" do
    login_user users(:john)
    get :new
    assert_response :success
  end

  test "POST create should redirect if successful" do
    login_user users(:john)
    ROTP::TOTP.any_instance.stubs(:verify).returns(true)
    post :create, params: { two_factor_auth: { code: "1234" }}
    assert_response :redirect
  end

  test "POST create should render :new with status success when entering a wrong code" do
    user = users(:john).tap { |u| u.update(totp_secret: "abc") }
    login_user user

    post :create, params: { two_factor_auth: { code: "invalid-code" }}
    assert_response :success
  end
end
