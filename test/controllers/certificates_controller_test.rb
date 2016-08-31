require "test_helper"

class CertificatesControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  test "GET show should be successful" do
    login_as users(:john)
    app = apps(:example)

    get server_app_certificate_path(app.server, app)
    assert_response :success
  end

  test "POST create should be successful" do
    login_as users(:john)
    app = apps(:example)

    assert_enqueued_with(job: EnableSSLJob, args: [app]) do
      post server_app_certificate_path(app.server, app), params: { app: {
        ssl_enabled: 1,
        ssl_key: fixture_file_upload("test/fixtures/server.key"),
        ssl_cert: fixture_file_upload("test/fixtures/server.crt") } }
    end

    assert_response :redirect
  end

  test "DELETE destroy should disable SSL" do
    login_as users(:john)
    app = apps(:ssl_enabled_app)

    assert app.ssl_enabled?, "SSL should be enabled for this app"

    assert_enqueued_with(job: DisableSSLJob, args: [app]) do
      delete server_app_certificate_path(app.server, app)
    end

    refute app.reload.ssl_enabled?, "SSL should be disabled for this app"
    assert_response :redirect
  end
end
