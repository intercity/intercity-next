class ScheduleServerLoadReadingsJob < ApplicationJob
  queue_as :default

  def perform
    Server.where(status: :up).each do |server|
      cpu = SshExecution.new(server).
            execute(command: "uptime | awk '{print $10}' | tr -d '\n'").to_f
      cpu = 100 if cpu > 100
      memory = SshExecution.new(server).
               execute(command: "free | grep Mem | awk '{print $3/$2}' | tr -d '\n'").to_f
      disk = SshExecution.new(server).
             execute(command: "df | awk '{print $6,$5/100;}' | grep '^/ ' |  tr -d '\n /%'").to_f

      ServerLoadReading.create(
        server: server,
        cpu: cpu,
        memory: memory,
        disk: disk
      )
    end
  end
end
