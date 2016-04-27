require 'test_helper'

class HealthCheckJobTest < ActiveJob::TestCase
  test "#perform should call out to SshExecution to test if server is available" do
    server = servers(:example)

    FakeSshExecutioner.return_value = "0.4.6"
    HealthCheckJob.perform_now(server)
  end

  test "#perform updates the dokku_version of the server if it is out of sync" do
    server = servers(:example).tap { |s| s.update(dokku_version: "0.4.6") }

    FakeSshExecutioner.return_value = "0.4.8"
    HealthCheckJob.perform_now(server)

    assert_equal "v0.4.8", server.reload.dokku_version
  end

  test "#perform should put the server in down state if we can't connect" do
    server = servers(:example).tap { |s| s.update(status: "up") }

    FakeSshExecutioner.return_value = -> { raise Errno::EHOSTDOWN }
    HealthCheckJob.perform_now(server)

    assert_equal "down", server.reload.status
  end

  test "#perform should not run the check when status is other then up or down" do
    server = servers(:example).tap { |s| s.update(status: "installing") }

    SshExecution.any_instance.expects(:execute).never
    HealthCheckJob.perform_now(server)
  end
end
