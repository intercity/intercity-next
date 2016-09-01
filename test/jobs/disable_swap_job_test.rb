require "test_helper"

class DisableSwapJobTest < ActiveJob::TestCase
  test "#perform should call out to SSHExecution to disable swap" do
    server = servers(:example).tap { |s| s.update(swap_enabled: true) }

    SshExecution.any_instance.expects(:scp).once
    SshExecution.any_instance.expects(:execute).twice
    DisableSwapJob.perform_now(server)
  end
end
