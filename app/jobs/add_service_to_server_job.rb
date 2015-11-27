class AddServiceToServerJob < ActiveJob::Base
  queue_as :default

  def perform(server, service)
    SshExecution.new(server).execute(command: service.commands["install"])
  end
end
