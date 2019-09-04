class ListingsFacade

  attr_reader :id

  def initialize(keywords, location, radius, salary, page)
    @keywords = keywords
    @location = location
    @radius = radius
    @salary = salary
    @page = page
  end

  def return_all_listings
    listing_data = jooble_api_service.parse_listings_data
  end

  private

  attr_reader :keywords, :location, :radius, :salary, :page

  def jooble_api_service
    JoobleService.new(keywords, location, radius, salary, page)
  end

end
