class CreateDeployKeyJob < ApplicationJob
  queue_as :default

  def perform(server, deploy_key)
    SshExecution.new(server).execute(command: "echo '#{deploy_key.key}' | " \
                                     "sudo sshcommand acl-add dokku #{deploy_key.name}")
  end
end
