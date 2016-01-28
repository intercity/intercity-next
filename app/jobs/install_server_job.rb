class InstallServerJob < ActiveJob::Base
  queue_as :default

  def perform(server)
    @server = server
    server.update(dokku_version: server.latest_dokku_version)
    logger.info "========= START SERVER INSTALLATION"
    SshExecution.new(server).execute_with_block do |ssh|
      ssh.open_channel do |channel|
        channel.exec install_dokku do |exec_channel, _|
          exec_channel.on_data do |_, data|
            if data =~ /Initial apt-get update/
              server.update(install_step: 1)
            elsif data =~ /Installing docker/
              server.update(install_step: 2)
            elsif data =~ /Installing dokku/
              server.update(install_step: 3)
            elsif data =~ /Importing herokuish into docker/
              server.update(install_step: 4)
            end
            logger.info data
          end
        end
      end
    end
    logger.info "========= END SERVER INSTALLATION"
    server.update(status: "up")
  end

  private

  attr_reader :server

  def install_dokku
    "sudo echo 'dokku dokku/web_config boolean false' | debconf-set-selections && "\
      "sudo echo 'dokku dokku/vhost_enable boolean false' | debconf-set-selections && " \
      "sudo echo 'dokku dokku/hostname string intercity.dokku' | debconf-set-selections && " \
      "sudo echo 'dokku dokku/skip_key_file boolean true' | debconf-set-selections && " \
      "wget https://raw.githubusercontent.com/dokku/dokku/#{server.latest_dokku_version}/bootstrap.sh && "\
      "sudo DOKKU_TAG=#{server.latest_dokku_version} bash bootstrap.sh"
  end
end
