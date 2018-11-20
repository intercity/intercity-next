class DeleteEnvVarJob < ApplicationJob
  queue_as :default

  def perform(app, env_var_name)
    SshExecution.new(app.server).
      execute(command: "dokku config:unset -no-restart #{app.clean_name} #{env_var_name}")
  end
end
