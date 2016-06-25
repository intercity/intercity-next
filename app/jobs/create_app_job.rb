class CreateAppJob < ActiveJob::Base
  queue_as :default

  def perform(app)
    app.update(busy: true)
    commands = ["apps:create #{app.clean_name}", "config:unset #{app.clean_name} NO_VHOST"]
    DockerBuilder.new.for_app(app).
      add_env_var("PLAYBOOK", "execute_dokku.yml").
      add_encoded_vars("DOKKU_COMMAND", commands).run
    app.update(busy: false)
  end
end
