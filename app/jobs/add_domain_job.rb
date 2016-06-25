class AddDomainJob < ActiveJob::Base
  queue_as :default

  def perform(app, domain)
    command = ["domains:add #{app.clean_name} '#{domain}'"]
    DockerBuilder.new.set_app(app).
      add_env_var("PLAYBOOK", "execute_dokku.yml").
      add_encoded_vars("DOKKU_COMMAND", command).run
  end
end
