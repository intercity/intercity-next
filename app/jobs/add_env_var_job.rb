class AddEnvVarJob < ApplicationJob
  queue_as :default

  def perform(app, env_var)
    SshExecution.new(app.server).execute(command: "dokku config:set "\
                                         "#{app.clean_name} '#{env_var.key}=#{env_var.value}'")
  end
end
