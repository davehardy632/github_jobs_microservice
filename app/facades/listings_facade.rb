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
    listing_data[:jobs].map do |listing|
      listing[:snippet] = listing[:snippet].gsub("\r\n", "")
      listing[:updated] = listing[:updated].split("T")[0]
      if listing[:snippet].include?("Ref ID:")
        listing[:snippet] = listing[:snippet].split("Ref ID:")[1].split("Classification:")[1]
      elsif listing[:snippet].include?("&nbsp;...")
        listing[:snippet] = listing[:snippet].split("&nbsp;...")[1]
      end
    end
    listing_data
  end

  private

  attr_reader :keywords, :location, :radius, :salary, :page

  def jooble_api_service
    JoobleService.new(keywords, location, radius, salary, page)
  end

end
