class ScheduleAutomatedBackupsJob < ActiveJob::Base
  queue_as :default

  def perform
    App.where(backups_enabled: true).each do |app|
      BackupScheduler.new(app).execute(type: :automatic)
    end
  end
end
