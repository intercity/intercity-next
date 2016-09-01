class SwapsController < ApplicationController
  def show
    @server = Server.find(params[:server_id])
  end

  def create
    change_swap(enabled: true)
  end

  def destroy
    change_swap(enabled: false)
  end

  private

  def change_swap(enabled: false)
    server = Server.find(params[:server_id])
    server.update(swap_enabled: enabled)
    if enabled
      EnableSwapJob.perform_later(server)
    else
      DisableSwapJob.perform_later(server)
    end
    redirect_to server_swap_path(server)
  end
end
