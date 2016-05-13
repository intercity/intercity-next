class ServerLoadReadingsController < ServerBaseController
  def index
    @server = Server.find(params[:server_id])
    respond_to do |format|
      format.html
      format.json { render json: data(@server) }
    end
  end

  private

  def data(server)
    data = server.server_load_readings.where("created_at > ?", Time.now - 4.hours)

    result = []
    [:cpu, :memory, :disk].each do |type|
      values = []
      data.each { |row| values << { x: row.created_at.strftime("%s%3N"), y: row.send(type) * 100 } }
      result << {
        key: type,
        values: values
      }
    end

    result
  end
end
