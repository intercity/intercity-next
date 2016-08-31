class CertificatesController < ApplicationController
  def show
    @app = Server.find(params[:server_id]).apps.find(params[:app_id])
  end

  def create
    @app = Server.find(params[:server_id]).apps.find(params[:app_id])
    if @app.update(ssl_enabled: true, ssl_key: read_file(:ssl_key), ssl_cert: read_file(:ssl_cert))
      EnableSSLJob.perform_later(@app)
      redirect_to server_app_certificate_path(@app.server, @app)
    else
      @app.ssl_enabled = false
      render :show
    end
  end

  def destroy
    @app = Server.find(params[:server_id]).apps.find(params[:app_id])
    @app.update(ssl_enabled: false, ssl_key: nil, ssl_cert: nil)
    DisableSSLJob.perform_later(@app)
    redirect_to server_app_certificate_path(@app.server, @app)
  end

  private

  def read_file(key)
    return unless params[:app] && params[:app][key].present?
    params[:app][key].read.chomp
  end
end
