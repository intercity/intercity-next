class RotateBackupsJob < ApplicationJob
  def perform
    backups = Backup.where("created_at < ?", 2.days.ago).where(rotated: false)

    backups.each do |backup|
      if File.exists?(Rails.root.join("backups", backup.app.clean_name, backup.filename))
        File.delete(Rails.root.join("backups", backup.app.clean_name, backup.filename))
      end
      backup.update(rotated: true, running: false)
    end
  end
end
