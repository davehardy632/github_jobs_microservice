class TeleportDetailsService

  def initialize(slug_url)
    @slug_url = slug_url
  end

  def details_response
    response = conn.get
    JSON.parse(response.body, symbolize_names: true)
  end

  def return_slug
    slug_url
  end

  def conn
    Faraday.new(url: "#{slug_url}" + "details") do |f|
      f.adapter Faraday.default_adapter
    end
  end

  private

  attr_reader :slug_url

end
