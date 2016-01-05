require "test_helper"

class BackupSchedulerTest < ActiveSupport::TestCase
  test "#execute should schedule backups for the given app with Manual status" do
    app = apps(:example)

    assert_difference "app.backups.count" do
      CreateBackupJob.expects(:perform_later)
      BackupScheduler.new(app).execute(type: :manual)
    end

    assert_equal "manual", Backup.last.backup_type
  end

  test "#execute should schedule backups for the given app with Automatic status" do
    app = apps(:example)

    assert_difference "app.backups.count" do
      CreateBackupJob.expects(:perform_later)
      BackupScheduler.new(app).execute(type: :automatic)
    end

    assert_equal "automatic", Backup.last.backup_type
  end
end
