require 'test_helper'

class ScheduleHealthChecksJobTest < ActiveJob::TestCase
  test "#perform should schedule a healthcheck for every available server" do
    available_servers = 2

    HealthCheckJob.expects(:perform_later).times(available_servers)
    ScheduleHealthChecksJob.perform_now
  end
end
