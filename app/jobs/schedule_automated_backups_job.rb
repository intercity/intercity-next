class ScheduleAutomatedBackupsJob < ActiveJob::Base
  queue_as :default

  def perform
    App.all.each do |app|
      BackupScheduler.new(app).execute(type: :automatic)
    end
  end
end
