class LinkServiceToAppJob < ActiveJob::Base
  queue_as :default

  def perform(app, service)
    create_command = service.commands["create"].gsub(/%app_name%/, app.clean_name)
    link_command = service.commands["link"].gsub(/%app_name%/, app.clean_name)
    SshExecution.new(app.server).execute(command: create_command)
    SshExecution.new(app.server).execute(command: link_command)
    app.linked_service(service).update(status: "installed")
  end
end
