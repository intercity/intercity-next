class RefreshLetsEncryptCertificateJob < ApplicationJob
  def perform(app)
    SshExecution.new(app.server).execute(command: "sudo dokku letsencrypt #{app.clean_name}")
  end
end
