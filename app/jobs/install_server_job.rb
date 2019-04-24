class InstallServerJob < ApplicationJob
  queue_as :default

  def perform(server)
    @server = server
    server.update(dokku_version: server.latest_dokku_version)

    perform_installation

    server.update(status: "up")
    ServerResourceGatherer.new(server).execute

    # Ensure we give Curl enough time to download buildpacks
    SshExecution.new(server).execute(command: "dokku config:set --global CURL_TIMEOUT=300")
  end

  private

  attr_reader :server

  def install_dokku
    "sudo echo 'dokku dokku/web_config boolean false' | sudo debconf-set-selections && "\
      "sudo echo 'dokku dokku/vhost_enable boolean false' | sudo debconf-set-selections && " \
      "sudo echo 'dokku dokku/hostname string intercity.dokku' | sudo debconf-set-selections && " \
      "sudo echo 'dokku dokku/skip_key_file boolean true' | sudo debconf-set-selections && " \
      "wget -O bootstrap.sh https://raw.githubusercontent.com/dokku/dokku/#{server.latest_dokku_version}/bootstrap.sh && "\
      "sudo DOKKU_TAG=#{server.latest_dokku_version} bash bootstrap.sh"
  end

  def perform_installation
    SshExecution.new(server).execute_with_block do |ssh|
      ssh.open_channel do |channel|
        channel.exec install_dokku
        channel.on_data do |_, data|
          if data =~ /Initial apt-get update/
            server.update(install_step: 1)
          elsif data =~ /Installing docker/
            server.update(install_step: 2)
          elsif data =~ /Installing dokku/
            server.update(install_step: 3)
          elsif data =~ /Importing herokuish into docker/
            server.update(install_step: 4)
          end
        end
      end

      ch.wait
    end
  end
end
