measurements = [:cpu, :memory, :disk]

json.array!(measurements) do |measurement|
  json.values(@readings) do |reading|
    json.y reading.try(measurement) * 100
    json.x reading.created_at.strftime("%s%3N")
  end
  json.key measurement
end
