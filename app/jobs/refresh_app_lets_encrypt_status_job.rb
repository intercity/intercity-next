class RefreshAppLetsEncryptStatusJob < ApplicationJob
  queue_as :default

  def perform(app)
    server = app.server

    letsencrypt_email = SshExecution.new(server).
                        execute(command: "sudo dokku config:get #{app.clean_name} DOKKU_LETSENCRYPT_EMAIL")

    if letsencrypt_email.present?
      app.update(letsencrypt_email: letsencrypt_email, letsencrypt_enabled: true)
    else
      app.update(letsencrypt_email: nil, letsencrypt_enabled: false)
    end
  end
end
