class InstallServerJob < ActiveJob::Base
  queue_as :default
  DOKKU_VERSION = "v0.4.11"

  def perform(server)
    server.update(dokku_version: DOKKU_VERSION)
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
          end
        end
      end
    end
    server.update(status: "up")
  end

  private

  def install_dokku
    "sudo echo 'dokku dokku/web_config boolean false' | debconf-set-selections && "\
      "sudo echo 'dokku dokku/vhost_enable boolean false' | debconf-set-selections && " \
      "sudo echo 'dokku dokku/skip_key_file boolean true' | debconf-set-selections && " \
      "wget https://raw.githubusercontent.com/dokku/dokku/#{DOKKU_VERSION}/bootstrap.sh && "\
      "sudo DOKKU_TAG=#{DOKKU_VERSION} bash bootstrap.sh"
  end
end
