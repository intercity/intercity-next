class ServersController < ApplicationController
  def index
    @servers = Server.all
  end

  def new
    @server = Server.new
  end

  def create
    @server = Server.new(server_params)
    if @server.save
      flash[:success] = "Your new server is added to your dashboard"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def server_params
    params.require(:server).permit(:name, :ip)
  end
end
