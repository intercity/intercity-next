require "test_helper"

class SshKeyMaintainerTest < ActiveSupport::TestCase
  test "create_ssh_key_for_connection creates a ssh_key" do
    server = servers(:example)

    ssh_key_maintainer = SshKeyMaintainer.new(server)
    ssh_file = ssh_key_maintainer.create_key_for_connection
    assert File.exist?("keys/#{ssh_file}")
    File.delete("keys/#{ssh_file}")
  end
end
