class CreateDeployKeyJob < ActiveJob::Base
  queue_as :default

  def perform(server, deploy_key)
    SshExecution.new(server).execute(command: "echo '#{deploy_key.key}' | " \
                                     "sshcommand acl-add dokku #{deploy_key.name}")
  end
end
