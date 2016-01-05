class SshExecution
  def initialize(server)
    @server = server
  end

  def execute(command:)
    execute_with_block do |ssh|
      return ssh.exec!(command)
    end
  end

  def scp(from:, to:)
    ssh_key_maintainer.create_key_for_connection
    cmd = "scp -i #{ssh_key_maintainer.key} root@#{@server.ip}:#{from} #{to}"
    system(cmd)
  ensure
    ssh_key_maintainer.delete_ssh_key_for_connection
  end

  def execute_with_block
    ssh_key_maintainer.create_key_for_connection
    Net::SSH.start(@server.ip, "root",
                   port: 22,
                   keys: [ssh_key_maintainer.key], paranoid: false,
                   timeout: ssh_timeout,
                   number_of_password_prompts: 0) do |ssh|
      yield ssh
    end
  ensure
    ssh_key_maintainer.delete_ssh_key_for_connection
  end

  private

  def ssh_key_maintainer
    @ssh_key_maintainer ||= SshKeyMaintainer.new(@server)
  end

  def ssh_timeout
    5
  end
end
