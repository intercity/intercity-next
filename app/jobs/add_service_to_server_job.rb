class AddServiceToServerJob < ApplicationJob
  queue_as :default

  def perform(server, service)
    SshExecution.new(server).execute(command: service.commands["install"])
    server.service(service).update(status: "installed")
  end
end
