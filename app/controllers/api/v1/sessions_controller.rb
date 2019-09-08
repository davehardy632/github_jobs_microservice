class Api::V1::SessionsController < ApplicationController

  def index
    if check_headers
      user = User.find_by(email: request.env["HTTP_EMAIL"])
      if user && user.authenticate(request.env["HTTP_PASSWORD"])
        session[:user_api_key] = user.api_key
        render :json => {
          "first_name": user.first_name,
          "last_name": user.last_name,
          "email": user.email,
          "api_key": user.api_key
        }, status: :accepted
      elsif user && !user.authenticate(request.env["HTTP_PASSWORD"])
        render :json => {
          "error": "Invalid Credentials"
        }, status: :unauthorized
      else
        render :json => {
          "error": "Please create an account to login"
        }, status: :not_found
      end
    else
      render :json => {
        "error": "Invalid Headers"
      }, status: :bad_request
    end
  end

  def check_headers 
    headers.each do | header |
      if header == nil
        return false
      else
        return true
      end
    end
  end

  def headers
    [
      request.env["HTTP_EMAIL"], 
      request.env["HTTP_PASSWORD"]
    ]
  end


end