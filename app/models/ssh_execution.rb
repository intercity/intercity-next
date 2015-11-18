class SshExecution
  def initialize(server)
    @server = server
  end

  def execute(command:, channeled: false)
    ssh_key_maintainer.create_key_for_connection
    run_ssh(command, channeled)
  ensure
    ssh_key_maintainer.delete_ssh_key_for_connection
  end

  private

  def ssh_key_maintainer
    @ssh_key_maintainer ||= SshKeyMaintainer.new(@server)
  end

  def run_ssh(command, channeled = false)
    Net::SSH.start(@server.ip, "root",
                   port: 22,
                   keys: [ssh_key_maintainer.key], paranoid: false, timeout: ssh_timeout,
                   number_of_password_prompts: 0) do |ssh|
                     if channeled
                       ssh.open_channel do |channel|
                         channel.request_pty
                         channel.exec(command)
                         channel.on_data do |_ch, data|
                           logger.info(data.strip)
                         end
                       end
                     else
                       return ssh.exec!(command)
                     end
                   end
  end

  def ssh_timeout
    5
  end
end
