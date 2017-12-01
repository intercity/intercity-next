class UpdateServerJob < ApplicationJob
  queue_as :default

  def perform(server)
    @server = server
    SshExecution.new(server).execute_with_block do |ssh|
      ssh.open_channel do |channel|
        channel.exec update_command do |exec_channel, success|
          unless success
            logger.error "Could not update server"
            abort "could not update server"
          end
          exec_channel.on_data do |action_channel, data|
            if data =~ /Keyfile for initial user:/
              action_channel.send_data("\n")
            end
            logger.info data
          end
        end
      end
    end
    SshExecution.new(server).execute(command: "dokku ps:rebuildall")
    server.update(dokku_version: server.latest_dokku_version, updating: false)
  end

  private

  attr_reader :server

  def update_command
    "sudo echo 'dokku dokku/web_config boolean false' | debconf-set-selections && " \
      "sudo echo 'dokku dokku/hostname string intercity.dokku' | debconf-set-selections && " \
      "sudo echo 'dokku dokku/vhost_enable boolean false' | debconf-set-selections && " \
      "sudo echo 'dokku dokku/skip_key_file boolean true' | debconf-set-selections && " \
      "sudo apt-get install -qq -y dokku"
  end
end
