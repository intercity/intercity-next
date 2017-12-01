class DeleteDomainJob < ApplicationJob
  queue_as :default

  def perform(app, domain)
    SshExecution.new(app.server).
      execute(command: "dokku domains:remove #{app.clean_name} '#{domain}'")
  end
end
