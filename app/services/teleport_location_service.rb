class TeleportLocationService

  def initialize(lat_long_obj)
    @latitude = lat_long_obj[:lat]
    @longitude = lat_long_obj[:lng]
  end

  def closest_urban_area
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.teleport.org/api/locations/#{latitude}%2C#{longitude}/") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :latitude, :longitude

end
