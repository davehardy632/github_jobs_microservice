class Api::V1::UrbanAreaDetailsController < ApplicationController

  def index
    if valid_header?
      render :json => JSON.parse(city_details_facade.return_details.to_json()), :status => :ok
    else
      invalid_header = {
        error: "Missing location header",
        status: 400
      }
        render :json => invalid_header, :status => :unauthorized
      end
  end

  private

  def valid_header?
    if request.env["HTTP_LOCATION"] != nil
      return true
    else
      return false
    end
  end

  def city_details_facade
    CityDetailsFacade.new(request.env["HTTP_LOCATION"])
  end
end
