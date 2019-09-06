class CityDataFacade

  def initialize(location)
    @location = location
  end

  def city_data_info
    teleport_city_search.return_city_data
  end

  def city_info_url
    city_data_info[:_embedded][:"city:search-results"][0][:_links][:"city:item"][:href]
  end

  def 

  def quality_of_life_stats
    teleport_basic_city_info_service.basic_city_info
    binding.pry
  end

  private

  attr_reader :location

  def teleport_city_search
    TeleportCitySearchService.new(location)
  end

  def teleport_basic_city_info_service
    TeleportBasicCityInfoService.new(city_info_url)
  end

end
