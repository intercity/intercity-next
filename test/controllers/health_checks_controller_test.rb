require 'test_helper'

class HealthChecksControllerTest < ActionController::TestCase
  test "should get create" do
    login_user users(:john)
    server = servers(:example)

    HealthCheckJob.any_instance.expects(:perform_now)

    post :create, xhr: true, params: {  server_id: server }

    assert_response :success
  end
end
