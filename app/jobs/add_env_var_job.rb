class AddEnvVarJob < ApplicationJob
  queue_as :default

  def perform(app, env_var)
    @apply_immediately = env_var.apply_immediately

    SshExecution.new(app.server).
      execute(command: "dokku config:set #{no_restart_argument}"\
        "#{app.clean_name} '#{env_var.key}=#{env_var.value}'")
  end

  private

  def no_restart_argument
    return if @apply_immediately

    "-no-restart "
  end
end
