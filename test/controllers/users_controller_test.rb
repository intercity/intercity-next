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
end
