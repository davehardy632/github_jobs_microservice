class GoogleGeocodeApiService

  def initialize(location)
    @location = location
  end

  def lat_long_obj
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://maps.googleapis.com/maps/api/geocode/json?address=#{location}&key=#{ENV["GOOGLE_GEOCODE_API_KEY"]}") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :location
end
