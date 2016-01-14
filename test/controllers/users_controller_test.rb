require "test_helper"

class UsersControllerTest < ActionController::TestCase
  include ActiveJob::TestHelper

  test "GET index should be successfull" do
    login_user(users(:john))
    get :index
    assert_response :success
  end

  test "POST create should create a new user" do
    login_user(users(:john))
    assert_difference "User.count" do
      perform_enqueued_jobs do
        xhr :post, :create, user: { email: "example@mail.org" }
        delivered_email = ActionMailer::Base.deliveries.last
        assert_includes delivered_email.to, "example@mail.org"
      end
    end

    assert_response :success
  end

  test "GET activate should be successfull" do
    user = users(:jane)
    get :activate, token: user.activation_token

    assert_response :success
  end

  test "POST confirm should be successfull" do
    user = users(:jane)
    patch :confirm, token: user.activation_token, user: { password: "secret_password" }

    assert_response :redirect
  end
end
