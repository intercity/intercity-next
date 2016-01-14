require 'test_helper'

class HealthChecksControllerTest < ActionController::TestCase
  test "should get create" do
    login_user users(:john)
    server = servers(:example)

    HealthCheckJob.any_instance.expects(:perform_now)

    xhr :post, :create, server_id: server

    assert_response :success
  end
end
