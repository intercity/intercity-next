class ServerResourceGatherer
  attr_reader :server

  def initialize(server)
    @server = server
  end

  def execute
    return if server.total_cpu.present? && server.total_disk.present? && server.total_ram.present?

    commands = {
      cpu: "lscpu | grep 'CPU MHz' | awk '{print $3}'",
      ram: "cat /proc/meminfo | grep MemTotal | awk '{ print $2}'",
      disk: "df |grep '^/dev/' | awk 'NR==1{print $2}'"
    }

    results = {}
    SshExecution.new(server).execute_with_block do |ssh|
      commands.each do |type, command|
        results[type] = ssh.exec!(command)
      end
    end

    server.update(total_cpu: results[:cpu],
                  total_disk: results[:disk],
                  total_ram: results[:ram])
  end
end
