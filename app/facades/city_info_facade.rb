class CityInfoFacade

  def initialize(location)
    @location = location
  end

  def return_lat_long
    google_geocode_service.lat_long_obj[:results][0][:geometry][:location]
  end


  def city_url
    teleport_location_service.closest_urban_area[:_embedded][:"location:nearest-cities"][0][:_links][:"location:nearest-city"][:href]
  end

  def return_info
    response_obj = {}
    raw_data = teleport_basic_city_info_service.basic_city_info
    response_obj[:full_name] = raw_data[:full_name]
    response_obj[:population] = raw_data[:population]
    response_obj
    binding.pry
  end

  private

  attr_reader :location

  def google_geocode_service
    GoogleGeocodeApiService.new(location)
  end

  def teleport_location_service
    TeleportLocationService.new(return_lat_long)
  end

  def teleport_basic_city_info_service
    TeleportBasicCityInfoService.new(city_url)
  end
end
