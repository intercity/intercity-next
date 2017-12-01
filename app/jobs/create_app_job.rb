class CreateAppJob < ApplicationJob
  queue_as :default

  def perform(app)
    app.update(busy: true)
    SshExecution.new(app.server).execute(command: "dokku apps:create #{app.clean_name}")
    SshExecution.new(app.server).execute(command: "dokku configs:unset #{app.clean_name} NO_VHOST")
    app.update(busy: false)
  end
end
