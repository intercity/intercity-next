class ServerLoadReadingJob < ApplicationJob
  queue_as :default

  def perform
    Server.where(status: :up).each do |server|
      commands = {
        cpu: "uptime | awk '{print $10}' | tr -d '\n'",
        memory: "free | grep Mem | awk '{print $3/$2}' | tr -d '\n'",
        disk: "df | awk '{print $6,$5/100;}' | grep '^/ ' |  tr -d '\n /%'"
      }

      results = {}
      SshExecution.new(server).execute_with_block do |ssh|
        commands.each do |type, command|
          results[type] = ssh.exec!(command)
        end
      end

      ServerLoadReading.create!(
        server: server,
        cpu: results[:cpu].to_f,
        memory: results[:memory].to_f,
        disk: results[:disk].to_f
      )
    end
  end
end
