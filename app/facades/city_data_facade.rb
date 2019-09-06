class CityDataFacade

  def initialize(location)
    @location = location
  end

  def lat_long_response
    google_geocode_service.lat_long_obj[:results][0][:geometry][:location]
  end

  def urban_area_url
    if teleport_location_service.closest_urban_area[:_embedded][:"location:nearest-urban-areas"] == []
      teleport_location_service.closest_urban_area[:_embedded][:"location:nearest-cities"][0][:_links][:"location:nearest-city"][:href]
    else
      teleport_location_service.closest_urban_area[:_embedded][:"location:nearest-urban-areas"][0][:_links][:"location:nearest-urban-area"][:href]
    end
  end

  def salaries_obj
    no_salary_data = {
      message: "There is no available salary data for this city."
    }
    if teleport_city_salaries_service.return_salaries[:message] == "Not Found"
      no_salary_data
    else
      teleport_city_salaries_service.return_salaries
    end
  end

  def average_salaries
    if salaries_obj[:salaries]
      salaries_obj[:salaries]
    else
      salaries_obj
    end
  end

  def non_urban_data(response)
    non_urban_data_response = {}
    non_urban_data_response[:full_name] = response[:full_name]
    non_urban_data_response[:population] = response[:population]
    non_urban_data_response[:status] = "Nearest urban area info is currently unavailable."
    non_urban_data_response
  end

  def urban_data(response)
    score_response = {}
    score_response[:teleport_city_score] = response[:teleport_city_score]
    score_response[:summary] = response[:summary]
    score_response[:categories] = response[:categories]
    score_response
  end

  def urban_area_scores
    if teleport_city_scores_service.return_scores.keys[1] == :categories
      urban_data(teleport_city_scores_service.return_scores)
    else
      non_urban_data(teleport_city_scores_service.return_scores)
    end
  end

  def quality_of_life_scores
    urban_area_scores
  end

  private

  attr_reader :location

  def teleport_city_scores_service
    TeleportCityScoresService.new(urban_area_url)
  end

  def teleport_city_salaries_service
    TeleportCitySalariesService.new(urban_area_url)
  end

  def teleport_location_service
    TeleportLocationService.new(lat_long_response)
  end

  def google_geocode_service
    GoogleGeocodeApiService.new(location)
  end

end
