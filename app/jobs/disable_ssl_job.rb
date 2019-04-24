class DisableSSLJob < ApplicationJob
  def perform(app)
    SshExecution.new(app.server).execute(command: "sudo dokku certs:remove #{app.clean_name}")
  end
end
