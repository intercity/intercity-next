class AppsController < ApplicationController
  def index
    @server = Server.includes(:apps).find(params[:server_id])
  end

  def new
    @app = App.new(server: server)
  end

  def create
    @app = App.new(app_params)
    if @app.save
      CreateAppJob.perform_later(@app)
      redirect_to server_apps_path(server)
    else
      render :new
    end
  end

  def show
    @app = Server.find(params[:server_id]).apps.find(params[:id])
  end

  def destroy
    @app = App.find(params[:id])

    RemoveAppJob.perform_later(server, @app.name)
    @app.destroy
    redirect_to server_apps_path(server)
  end

  private

  def server
    @server ||= Server.find(params[:server_id])
  end

  def app_params
    params.require(:app).permit(:name).tap do |p|
      p[:server] = server
    end
  end
end
