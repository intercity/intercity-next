require "test_helper"

class RemoveServiceJobTest < ActiveJob::TestCase
  test "#perform should execute the unlink and destroy command" do
    server = servers(:example)
    app = apps(:example)

    SshExecution.any_instance.expects(:execute).twice
    RemoveServiceJob.perform_now(server, app.clean_name, services(:redis))
  end
end
