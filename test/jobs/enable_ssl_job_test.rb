require "test_helper"

class EnableSSLJobTest < ActiveJob::TestCase
  test "#perform should call out to SSHExecution to install the cert" do
    app = apps(:example).tap { |a| a.update(ssl_enabled: true, ssl_key: "abc", ssl_cert: "def") }

    SshExecution.any_instance.expects(:scp).times(2)
    SshExecution.any_instance.expects(:execute).times(3)
    EnableSSLJob.perform_now(app)
  end
end
