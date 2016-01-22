require 'test_helper'

class ScheduleAutomatedBackupsJobTest < ActiveJob::TestCase
  test "#perform calls BackupScheduler for all apps" do
    backups_enabled_count = App.where(backups_enabled: true).count

    BackupScheduler.any_instance.expects(:execute).times(backups_enabled_count)
    ScheduleAutomatedBackupsJob.perform_now
  end
end
