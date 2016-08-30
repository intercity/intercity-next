class AppServicesController < ServerBaseController
  def index
    @app = server.apps.find(params[:app_id])
  end

  def create
    @app = Server.find(params[:server_id]).apps.find(params[:app_id])
    @service = Service.find(params[:id])
    @app.services << @service

    LinkServiceToAppJob.perform_later(@app, @service)
    redirect_to server_app_services_path(@app.server, @app)
  end

  def status
    @app = Server.find(params[:server_id]).apps.find(params[:app_id])
    @service = Service.find(params[:id])
  end
end
