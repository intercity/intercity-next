class EnvVarsController < ServerBaseController
  def index
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @env_var = EnvVar.new
  end

  def create
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @env_var = @app.env_vars.new(env_var_params)
    AddEnvVarJob.perform_later(@app, @env_var) if @env_var.save
  end

  def destroy
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    @env_var = @app.env_vars.find(params[:id])
    DeleteEnvVarJob.perform_later(@app, @env_var.key) if @env_var.destroy
  end

  def sync
    @app = App.find_by!(id: params[:app_id], server: params[:server_id])
    SyncEnvVarsJob.perform_later(@app)
  end

  private

  def env_var_params
    params.require(:env_var).permit(:key, :value)
  end
end
