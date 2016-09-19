require "test_helper"

class ServerResourceGathererTest < ActiveSupport::TestCase
  test "#execute should call out to SSHExecution if server resource was not known yet" do
    server = servers(:example)

    SshExecution.any_instance.expects(:execute_with_block).once
    ServerResourceGatherer.new(server).execute
  end

  test "#execute should not call to SSHExecution if server resources are already known" do
    server = servers(:example)
    server.total_cpu = 10
    server.total_ram = 10
    server.total_disk = 10

    SshExecution.any_instance.expects(:execute_with_block).never
    ServerResourceGatherer.new(server).execute
  end
end
