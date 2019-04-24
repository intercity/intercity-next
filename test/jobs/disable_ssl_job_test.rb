require "test_helper"

class DisableSSLJobTest < ActiveJob::TestCase
  test "#perform should call out to SSHExecution" do
    app = apps(:ssl_enabled_app)

    SshExecution.any_instance.expects(:execute).with(command: "sudo dokku certs:remove #{app.clean_name}")
    DisableSSLJob.perform_now(app)
  end
end
