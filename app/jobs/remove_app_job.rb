class RemoveAppJob < ActiveJob::Base
  queue_as :default

  def perform(server, app_name)
    SshExecution.new(server).execute_with_block do |ssh|
      ssh.open_channel do |channel|
        channel.exec "dokku apps:destroy #{app_name}" do |channel2, success|
          abort "could not destroy app" unless success

          channel2.on_data do |channel3, data|
            if data =~ /To proceed, type "#{app_name}"/
              channel3.send_data("#{app_name}\n")
            end
          end
        end
      end
    end
  end
end
