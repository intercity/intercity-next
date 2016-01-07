class BackupScheduler
  def initialize(app)
    @app = app
  end

  def execute(type: :manual)
    app.services.each do |service|
      next unless service.commands["backup"]
      backup = app.backups.create!(service: service, running: true,
                                   backup_type: type.to_s)
      CreateBackupJob.perform_later(backup)
    end
  end

  private

  attr_accessor :app
end
