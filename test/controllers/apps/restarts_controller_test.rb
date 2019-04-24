require 'test_helper'

class Apps::RestartsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test "POST create enqueues RestartAppJob" do
    login_as users(:john)
    app = apps(:example)

    assert_enqueued_jobs 1, only: RestartAppJob do
      post server_app_restarts_url(app.server, app), xhr: true
    end
  end
end
