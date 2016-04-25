class ServerLoadReadingsController < ServerBaseController
  def index
    @server = Server.find(params[:server_id])
    @readings = @server.server_load_readings.where("created_at > ?", Time.now - 4.hours)

    respond_to do |format|
      format.html
      format.json
    end
  end
end
