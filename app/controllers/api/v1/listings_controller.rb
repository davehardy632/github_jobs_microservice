class Api::V1::ListingsController < ApplicationController

  def index
    if listings_params.include?("location") || listings_params.include?("keywords")
      render json: ListingsSerializer.new(listings_facade)
    else
      payload = {
        error: "Missing required parameters",
        status: 400
      }
        render :json => payload, :status => :unauthorized
      end
  end

  private

  def listings_params
    params.permit("keywords", "location", "radius", "salary", "page")
  end

  def listings_facade
    ListingsFacade.new(listings_params["keywords"], listings_params["location"], listings_params["radius"], listings_params["salary"], listings_params["page"])
  end
  
end
