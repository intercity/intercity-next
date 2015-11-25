class RemoveAppJob < ActiveJob::Base
  queue_as :default

  def perform(server, app_name)
    # SshExecution.new(server).execute(command: "dokku apps:destroy #{app_name.parameterize}")
  end
end
