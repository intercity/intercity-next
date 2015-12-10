class AddDomainJob < ActiveJob::Base
  queue_as :default

  def perform(app, domain)
    SshExecution.new(app.server).
      execute(command: "dokku domains:add #{app.clean_name} '#{domain}'")
  end
end
