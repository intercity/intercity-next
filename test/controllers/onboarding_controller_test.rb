require "test_helper"

class OnboardingControllerTest < ActionController::TestCase
  test "GET index should be successfull when there are no other users" do
    User.destroy_all

    get :index

    assert_response :success
  end

  test "GET index should be successfull even when there are no settings yet" do
    User.destroy_all
    Setting.destroy_all

    get :index

    assert_response :success
  end

  test "GET index should redirect to root path when there is a user in the system" do
    get :index

    assert_response :redirect
  end

  test "POST create should create a new user if there are no other users" do
    User.destroy_all

    assert_difference "User.count" do
      post :create, params: { user: { email: "user@example.com", password: "secret_password" } }
    end

    assert_response :redirect
  end
end
