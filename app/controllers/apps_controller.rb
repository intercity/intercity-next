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
      CreateAppJob.perform_later(@app)
      redirect_to server_apps_path(server)
    else
      render :new
    end
  end

  def destroy
    @app = App.find(params[:id])
    # TODO: Find a way to actually remove this app on the server
    # For now, lets just remove it from the dashboard
    RemoveAppJob.perform_later(server, @app.name)
    @app.destroy
    redirect_to server_apps_path(server)
  end

  private

  def server
    @server ||= Server.find(params[:server_id])
  end

  def server_params
    params.require(:app).permit(:name, :domain).tap do |p|
      p[:server] = server
    end
  end
end
