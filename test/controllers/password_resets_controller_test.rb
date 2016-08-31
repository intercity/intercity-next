require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test "GET new should be successful" do
    get new_password_reset_path
    assert_response :success
  end

  test "POST create shoud be successful if the user exists" do
    user = users(:john)

    assert_nil user.reset_password_token

    perform_enqueued_jobs do
      assert_difference "ActionMailer::Base.deliveries.size" do
        post password_resets_path, params: { user: { email: "john@example.com" } }
      end
    end

    refute_nil user.reload.reset_password_token

    assert_response :redirect
  end

  test "GET edit should be successful with a valid token" do
    user = users(:john).tap { |u| u.generate_reset_password_token }

    get edit_password_reset_path(user.reset_password_token)
    assert_response :success
  end

  test "PATCH update should change the password" do
    user = users(:john).tap { |u| u.generate_reset_password_token }

    old_password = user.crypted_password

    patch password_reset_path(user.reset_password_token), params: { user: { password: "12345678" }}

    refute_equal old_password, user.reload.crypted_password

    assert_response :redirect
  end
end
