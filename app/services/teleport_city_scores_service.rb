class TeleportCityScoresService

  def initialize(slug_url)
    @slug_url = slug_url
  end

  def return_scores
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    if slug_url.split("/")[4] == "urban_areas"
      Faraday.new(url: "#{slug_url}" + "scores") do |f|
        f.adapter Faraday.default_adapter
      end
    else
      Faraday.new(url: slug_url) do |f|
        f.adapter Faraday.default_adapter
      end
    end
  end

  private

  attr_reader :slug_url

end
