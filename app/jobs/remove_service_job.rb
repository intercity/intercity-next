class RemoveServiceJob < ApplicationJob
  queue_as :default

  def perform(server, app_name, service)
    unlink_command = service.commands["unlink"].gsub(/%app_name%/, app_name)
    destroy_command = service.commands["destroy"].gsub(/%app_name%/, app_name)
    SshExecution.new(server).execute(command: unlink_command)
    SshExecution.new(server).execute(command: destroy_command)
  end
end
