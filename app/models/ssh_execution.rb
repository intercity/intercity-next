class SshExecution
  class_attribute :executioner
  self.executioner = Net::SSH

  def initialize(server)
    @server = server
  end

  def execute(command:)
    execute_with_block do |ssh|
      return ssh.exec!(command)
    end
  end

  def scp(from:, to:, direction: :download)
    ssh_key_maintainer.create_key_for_connection
    case direction
    when :upload
      # rubocop:disable Metrics/LineLength
      cmd = "scp -oStrictHostKeyChecking=no -i #{ssh_key_maintainer.key} #{from} #{@server.username}@#{@server.ip}:#{to}"
    else
      cmd = "scp -oStrictHostKeyChecking=no -i #{ssh_key_maintainer.key} #{@server.username}@#{@server.ip}:#{from} #{to}"
      # rubocop:enable Metrics/LineLength
    end
    system(cmd)
  ensure
    ssh_key_maintainer.delete_ssh_key_for_connection
  end

  def execute_with_block
    ssh_key_maintainer.create_key_for_connection
    executioner.start(@server.ip, @server.username,
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
