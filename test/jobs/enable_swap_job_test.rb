require "test_helper"

class EnableSwapJobTest < ActiveJob::TestCase
  test "#perform should call out to SSHExecution to enable swap" do
    server = servers(:example).tap { |s| s.update(swap_enabled: false) }

    SshExecution.any_instance.expects(:scp).once
    SshExecution.any_instance.expects(:execute).twice
    EnableSwapJob.perform_now(server)
  end
end
