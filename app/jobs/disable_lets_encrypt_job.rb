class DisableLetsEncryptJob < ApplicationJob
  queue_as :default

  def perform(app)
    SshExecution.new(app.server).
      execute(command: "sudo dokku config:unset -no-restart #{app.clean_name} DOKKU_LETSENCRYPT_EMAIL")
    SshExecution.new(app.server).
      execute(command: "sudo dokku letsencrypt:revoke #{app.clean_name}")
    app.update(letsencrypt_enabled: false)
  end
end
