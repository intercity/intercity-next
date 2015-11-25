class CreateAppJob < ActiveJob::Base
  queue_as :default

  def perform(app)
    @app = app
    app.update(busy: true)
    SshExecution.new(app.server).execute(command: "dokku apps:create #{app_name}")
    SshExecution.new(app.server).execute(command: "dokku domains:add #{app_name} #{app.domain}")
    app.update(busy: false)
  end

  private

  attr_reader :app

  def app_name
    app.name.parameterize
  end
end
