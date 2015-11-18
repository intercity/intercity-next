class AppsController < ApplicationController
  def index
    @server = Server.includes(:apps).find(params[:server_id])
  end

  def new
    @app = App.new(server: server)
  end

  def create
    @app = App.new(server_params)
    if @app.save
      redirect_to server_apps_path(server)
    else
      render :new
    end
  end

  private

  def server
    @server ||= Server.find(params[:server_id])
  end

  def server_params
    params.require(:app).permit(:name).tap do |p|
      p[:server] = server
    end
  end
end
