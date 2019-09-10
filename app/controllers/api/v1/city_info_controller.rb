class Api::V1::CityInfoController < ApplicationController


  def index
    if valid_header?
      render :json => JSON.parse(city_info_facade.return_info.to_json()), :status => :ok
    else
      invalid_header = {
        error: "Missing location header",
        status: 406
      }
        render :json => invalid_header, :status => :bad_request
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

  def city_info_facade
    CityInfoFacade.new(request.env["HTTP_LOCATION"])
  end

end
