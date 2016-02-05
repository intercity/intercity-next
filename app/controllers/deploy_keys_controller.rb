class DeployKeysController < ServerBaseController
  def index
    @server = Server.find(params[:server_id])
    @deploy_keys = @server.deploy_keys
    @deploy_key = DeployKey.new
  end

  def create
    @server = Server.find(params[:server_id])
    @deploy_key = @server.deploy_keys.new(deploy_key_params)
    if @deploy_key.save
      CreateDeployKeyJob.perform_later(@server, @deploy_key)
      flash[:success] = "Deploy key has been added"
    else
      flash[:error] = "Not all fields are filled in."
    end
    redirect_to server_deploy_keys_path(@server)
  end

  def destroy
    @server = Server.find(params[:server_id])
    deploy_key = @server.deploy_keys.find(params[:id])
    DeleteDeployKeyJob.perform_later(@server, deploy_key.name)
    deploy_key.destroy
    redirect_to server_deploy_keys_path(@server)
  end

  private

  def deploy_key_params
    params.require(:deploy_key).permit(:name, :key)
  end
end
