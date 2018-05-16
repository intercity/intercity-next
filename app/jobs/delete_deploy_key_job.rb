class DeleteDeployKeyJob < ApplicationJob
  queue_as :default

  def perform(server, deploy_key_name)
    SshExecution.new(server).execute(command: "sudo sshcommand acl-remove dokku #{deploy_key_name}")
  end
end
