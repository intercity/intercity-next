class ServicesController < ApplicationController
  def index
    @server = Server.find(params[:server_id])
    @available_services = Service.where(active: true)
    @services = @server.services
  end

  def create
    server = Server.find(params[:server_id])
    service = Service.find(params[:id])
    server.services << service unless server.services.include?(service)
    AddServiceToServerJob.perform_later(server, service)
    redirect_to server_services_path(server)
  end
end
