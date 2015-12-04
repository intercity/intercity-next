class AppServicesController < ApplicationController
  def index
    @app = Server.find(params[:server_id]).apps.find(params[:app_id])
  end

  def create
    @app = Server.find(params[:server_id]).apps.find(params[:app_id])
    @service = Service.find(params[:id])
    @app.services << @service

    LinkServiceToAppJob.perform_later(@app, @service)
    redirect_to server_app_path(@app.server, @app)
  end
end
