class SyncEnvVarsJob < ActiveJob::Base
  queue_as :default

  def perform(app)
    SshExecution.new(app.server).execute_with_block do |ssh|
      ssh.open_channel do |channel|
        channel.exec "dokku config #{app.clean_name}" do |exec_channel, success|
          unless success
            logger.error "Could not update env vars"
            abort "could not update env vars"
          end
          exec_channel.on_data do |_, data|
            next if data.starts_with?("=====>")
            key, value = data.split(":").map(&:strip)
            env_var = app.env_vars.find_or_initialize_by(key: key)
            env_var.update!(value: value)
          end
        end
      end
    end
  end
end
