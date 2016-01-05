require 'test_helper'

class ScheduleAutomatedBackupsJobTest < ActiveJob::TestCase
  test "#perform calls BackupScheduler for all apps" do
    app_count = App.count

    BackupScheduler.any_instance.expects(:execute).times(app_count)
    ScheduleAutomatedBackupsJob.perform_now
  end
end
