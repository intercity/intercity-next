class RestartAppJob < ApplicationJob
  queue_as :default

  def perform(app)
    SshExecution.new(app.server).
      execute(command: "dokku ps:restart #{app.clean_name}")
  end
end
