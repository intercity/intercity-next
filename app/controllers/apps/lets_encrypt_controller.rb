class Apps::LetsEncryptController < ServerBaseController
  def create
    @app = server.apps.find(params[:app_id])
    @app.fetch_letsencrypt_status_from_server!
    unless @app.letsencrypt_enabled?
      @app.assign_attributes(lets_encrypt_params)
      EnableLetsEncryptJob.perform_later(@app) if @app.save
    end

    redirect_to server_app_domains(@app.server, @app)
  end

  private

  def letsencrypt_params
    params.require(:app).permit(:letsencrypt_email)
  end
end
