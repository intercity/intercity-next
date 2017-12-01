class CreateBackupJob < ApplicationJob
  queue_as :default

  def perform(backup)
    unpack_backup_vars(backup)

    return unless service.commands["backup"]

    ensure_backup_directory

    @backup.update(filename: backup_name)
    run_backup
    @backup.update(running: false)
  end

  private

  attr_accessor :backup, :service, :app

  def backup_name
    @backup_name ||= "#{backup.app.clean_name}-#{service.name}-#{Time.now.to_s.parameterize}"
  end

  def run_backup
    SshExecution.new(app.server).execute(command: backup_command)
    SshExecution.new(app.server).scp(from: "/#{app.server.username}/#{backup_name}",
                                     to: Rails.root.join("backups", app.clean_name, backup_name))
    SshExecution.new(app.server).execute(command: "rm #{backup_name}")
  end

  def backup_command
    cmd = service.commands["backup"].gsub(/%app_name%/, app.clean_name)
    cmd += " > #{backup_name}"
    cmd
  end

  def ensure_backup_directory
    FileUtils.mkdir_p Rails.root.join("backups", app.clean_name)
  end

  def unpack_backup_vars(backup)
    @backup = backup
    @service = backup.service
    @app = backup.app
  end
end
