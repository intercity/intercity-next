class EnableLetsencryptJob < ApplicationJob
  queue_as :default

  def perform(app)
    @app = app
    return if app.letsencrypt_enabled?

    install_letsencrypt_plugin_if_needed

    SshExecution.new(app.server).
      execute(command: "dokku config:set -no-restart #{app.clean_name} DOKKU_LETSENCRYPT_EMAIL=#{app.letsencrypt_email}")
    SshExecution.new(app.server).
      execute(command: "dokku letsencrypt #{app.clean_name}")
  end

  private

  def install_letsencrypt_plugin_if_needed
    SshExecution.new(@app.server).
      execute(command: "dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git")
    # TODO enable cronjob
  end
end
