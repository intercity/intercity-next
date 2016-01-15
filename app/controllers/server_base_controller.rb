class ServerBaseController < ApplicationController
  before_action :redirect_if_updating

  protected

  def server
    @server ||= Server.find(params[:server_id])
  end

  def redirect_if_updating
    redirect_to updating_server_path(server) if server.updating?
  end
end
