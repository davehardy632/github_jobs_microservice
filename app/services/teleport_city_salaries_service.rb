class TeleportCitySalariesService

  def initialize(slug_url)
    @slug_url = slug_url
  end

  def return_salaries
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end


  def conn
    Faraday.new(url: "#{slug_url}" + "salaries") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :slug_url

end
