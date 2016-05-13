class SyncEnvVarsController < ServerBaseController
  def create
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    SyncEnvVarsJob.perform_later(@app)
  end
end
