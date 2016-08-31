class DisableSSLJob < ApplicationJob
  def perform(app)
    SshExecution.new(app.server).execute(command: "dokku certs:remove #{app.clean_name}")
  end
end
