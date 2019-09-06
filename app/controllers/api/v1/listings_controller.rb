class Api::V1::ListingsController < ApplicationController

  def index
    if request.headers["HTTP_KEYWORDS"] != nil || request.headers["HTTP_LOCATION"] != nil
      render :json => JSON.parse(listings_facade.return_all_listings.to_json()), :status => :ok
    else
      payload = {
        error: "Missing required headers",
        status: 400
      }
        render :json => payload, :status => :unauthorized
      end
  end

  private

  def listings_facade
    ListingsFacade.new(request.headers["HTTP_KEYWORDS"], request.headers["HTTP_LOCATION"], request.headers["HTTP_RADIUS"], request.headers["HTTP_SALARY"], request.headers["HTTP_PAGE"])
  end

end
