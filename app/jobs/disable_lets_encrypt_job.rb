class DisableLetsEncryptJob < ApplicationJob
  queue_as :default

  def perform(app)
    SshExecution.new(app.server).
      execute(command: "dokku config:unset -no-restart #{app.clean_name} DOKKU_LETSENCRYPT_EMAIL")
    SshExecution.new(app.server).
      execute(command: "dokku letsencrypt:revoke #{app.clean_name}")
  end
end
