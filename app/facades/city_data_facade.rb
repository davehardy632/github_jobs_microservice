class CityDataFacade

  def initialize(location)
    @location = location
  end

  def lat_long_response
    google_geocode_service.lat_long_obj[:results][0][:geometry][:location]
  end

  def urban_area_url
    teleport_location_service.closest_urban_area[:_embedded][:"location:nearest-urban-areas"][0][:_links][:"location:nearest-urban-area"][:href]
  end

  # def city_data_info
  #   teleport_city_search.return_city_data
  # end
  #
  # def city_info_url
  #   city_data_info[:_embedded][:"city:search-results"][0][:_links][:"city:item"][:href]
  # end
  #
  # def urban_area_link
  #   teleport_basic_city_info_service.basic_city_info[:_links][:"city:urban_area"][:href]
  # end

  # def quality_of_life_scores
  #   urban_area_url
  #   binding.pry
  # end
  #
  def urban_area_scores
    teleport_city_scores_service.return_scores
  end

  def score_categories
    urban_area_scores[:categories]
  end

  def score_summary
    urban_area_scores[:summary]
  end

  def total_avg_score
    urban_area_scores[:teleport_city_score]
  end

  def response_obj
    score_response = {}
    score_response[:teleport_city_score] = total_avg_score
    score_response[:summary] = score_summary
    score_response[:categories] = score_categories
    score_response
  end

  def quality_of_life_scores
    response_obj
  end

  private

  attr_reader :location
  #
  # def teleport_city_search
  #   TeleportCitySearchService.new(location)
  # end
  #
  # def teleport_basic_city_info_service
  #   TeleportBasicCityInfoService.new(city_info_url)
  # end

  def teleport_city_scores_service
    TeleportCityScoresService.new(urban_area_url)
  end

  def teleport_location_service
    TeleportLocationService.new(lat_long_response)
  end

  def google_geocode_service
    GoogleGeocodeApiService.new(location)
  end

end
