class TeleportBasicCityInfoService

  def initialize(city_url)
    @city_url = city_url
  end


  def basic_city_info
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: "#{city_url}") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :city_url

end
