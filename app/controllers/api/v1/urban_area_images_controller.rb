class Api::V1::UrbanAreaImagesController < ApplicationController

  def index
    if valid_header?
      render :json => JSON.parse(city_images_facade.return_images.to_json()), :status => :ok
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

  def city_images_facade
    CityImagesFacade.new(request.env["HTTP_LOCATION"])
  end
end
