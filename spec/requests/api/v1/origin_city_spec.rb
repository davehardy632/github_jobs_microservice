require 'rails_helper'

describe "Teleport Api return origin city data" do
  it "When a location header is sent for a city, that citys general info is returned" do
    get '/api/v1/city_info', headers: { 'HTTP_LOCATION' => "Louisville, CO" }

    expect(response).to be_successful

    city_info = JSON.parse(response.body)

    expect(city_info.count).to eq(3)
  end
end
