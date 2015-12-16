class InstallServerJob < ActiveJob::Base
  queue_as :default
  DOKKU_VERSION = "v0.4.6"

  def perform(server)
    server.update(dokku_version: DOKKU_VERSION)
    SshExecution.new(server).execute(command: install_dokku)
    server.update(status: "up")
  end

  private

  def install_dokku
    "wget https://raw.githubusercontent.com/dokku/dokku/#{DOKKU_VERSION}/bootstrap.sh &&
      sudo DOKKU_TAG=#{DOKKU_VERSION} bash bootstrap.sh"
  end
end
