require 'test_helper'

class BackupsControllerTest < ActionController::TestCase
  setup do
    login_user(users(:john))
  end

  test "GET index should be successfull" do
    app = apps(:example)
    get :index, params: { server_id: app.server, app_id: app }

    assert_response :success
  end

  test "POST enable should mark the app as backup enabled" do
    app = apps(:example).tap { |app| app.update(backups_enabled: false) }

    refute app.backups_enabled?, "App should have backups disabled"

    post :enable, params: { server_id: app.server, app_id: app }

    assert app.reload.backups_enabled?, "App should have backups enabled"
    assert_response :redirect
  end

  test "POST create should create a new running backup entry" do
    app = apps(:example)

    BackupScheduler.any_instance.expects(:execute)

    post :create, params: { server_id: app.server, app_id: app }

    assert_response :redirect
  end
end
