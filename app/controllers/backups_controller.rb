class BackupsController < ApplicationController
  def index
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @backups = @app.backups.order(created_at: :desc)
  end

  def create
    app = App.find_by!(id: params[:app_id], server: params[:server_id])
    app.services.each do |service|
      next unless service.commands["backup"]
      backup = app.backups.create!(service: service, running: true)
      CreateBackupJob.perform_later(backup)
    end
    redirect_to request.referer.presence || server_app_backups_path(server_id: app.server, app: app)
  end

  def enable
    app = App.find_by!(id: params[:app_id], server: params[:server_id])
    app.update(backups_enabled: true)
    redirect_to request.referer.presence || server_app_backups_path(server_id: app.server, app: app)
  end

  def status
    @backup = Backup.find(params[:id])
  end
end
