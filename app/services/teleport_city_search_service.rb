class TeleportCitySearchService

  def initialize(location)
    @location = location
  end

  def return_city_data
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "https://api.teleport.org/api/cities/?search=#{location}") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :location
end
