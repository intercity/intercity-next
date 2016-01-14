class HealthCheckJob < ActiveJob::Base
  queue_as :default

  def perform(server)
    return unless server.up? || server.down?
    version = SshExecution.new(server).execute(command: "dokku version")
    server.update(dokku_version: format_version(version), status: "up")

  rescue Net::SSH::ConnectionTimeout, Net::SSH::AuthenticationFailed, Errno::EHOSTUNREACH,
         Errno::ECONNREFUSED, Errno::EHOSTDOWN
    server.update(status: "down")
  end

  private

  def format_version(version)
    "v#{version.strip}"
  end
end
