class BackupsController < ServerBaseController
  def index
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @backups = @app.backups.order(created_at: :desc)
    @backups = @backups.page(params[:page]).per(15)
  end

  def create
    app = App.find_by!(id: params[:app_id], server: params[:server_id])
    BackupScheduler.new(app).execute
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
