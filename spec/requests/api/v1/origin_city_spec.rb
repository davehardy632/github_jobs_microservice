require 'rails_helper'
require 'webmock/rspec'

describe "Teleport Api return origin city data" do
  before :each do
    WebMock.disable!
  end
  it "When a location header is sent for a city, that citys general info is returned" do
    get '/api/v1/city_info', headers: { 'HTTP_LOCATION' => "Louisville, CO" }

    expect(response).to be_successful

    city_info = JSON.parse(response.body)

    expect(city_info.count).to eq(2)
  end

  it "When no location header is sent, an error message is returned with a 400 status" do
    get '/api/v1/city_info'

    error_message = JSON.parse(response.body)
    
    expect(error_message).to eq({"error"=>"Missing location header", "status"=>406})
  end
end
