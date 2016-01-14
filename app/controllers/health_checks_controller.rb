class HealthChecksController < ApplicationController
  def create
    @server = Server.find(params[:server_id])

    HealthCheckJob.perform_now(@server)
  end
end
