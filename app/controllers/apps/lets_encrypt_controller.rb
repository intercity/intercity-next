class Apps::LetsEncryptController < ServerBaseController
  def create
    @app = server.apps.find(params[:app_id])
    RefreshAppLetsEncryptStatusJob.new.perform(@app)
    unless @app.letsencrypt_enabled?
      EnableLetsEncryptJob.new.perform(@app) if @app.update(letsencrypt_params)
    end

    redirect_to server_app_domains_path(@app.server, @app)
  end

  def destroy
    @app = server.apps.find(params[:app_id])
    DisableLetsEncryptJob.new.perform(@app)

    redirect_to server_app_domains_path(@app.server, @app)
  end

  def update
    @app = server.apps.find(params[:app_id])
    RefreshLetsEncryptCertificateJob.perform_later(@app)
  end

  private

  def letsencrypt_params
    params.require(:app).permit(:letsencrypt_email)
  end
end
