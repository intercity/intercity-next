class ServerLoadReadingsController < ServerBaseController
  def index
  end

  def data
    data = Server.find(params[:server_id]).server_load_readings.where("created_at > ?", Time.now - 4.hours)

    result = []
    [:cpu, :memory, :disk].each do |type|
      values = []
      data.each { |row| values << { x: row.created_at.strftime("%s%3N"), y: row.send(type) * 100 } }
      result << {
        key: type,
        values: values
      }
    end
    render json: result
  end
end
