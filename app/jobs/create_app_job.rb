class CreateAppJob < ActiveJob::Base
  queue_as :default

  def perform(app)
    app.update(busy: true)
    SshExecution.new(app.server).execute(command: "dokku apps:create #{app.name.parameterize}")
    app.update(busy: false)
  end
end
