class ScheduleHealthChecksJob < ActiveJob::Base
  queue_as :health_cheacks

  def perform
    Server.all.each do |server|
      HealthCheckJob.perform_later(server)
    end
  end
end
