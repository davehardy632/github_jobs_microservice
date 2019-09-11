require 'rails_helper'
require 'webmock/rspec'

describe "Teleport api" do
  before :each do
    WebMock.disable!
  end
  it "A user can get data about a given city" do

    get '/api/v1/urban_area/details', headers: { 'HTTP_LOCATION' => "Denver, CO" }

    expect(response).to be_successful

    city_details = JSON.parse(response.body)

    expect(city_details.count).to eq(22)
    expect(city_details.first.keys).to eq(["data", "id", "label"])
    expect(city_details.first["data"][0].keys).to eq(["float_value", "id", "label", "type"])
    expect(city_details.last.keys).to eq(["data", "id", "label"])
    expect(city_details.last["data"][0].keys).to eq(["float_value", "id", "label", "type"])
  end

  it "A user cannot get data about a city if there is no associated urban area" do

    get '/api/v1/urban_area/details', headers: { 'HTTP_LOCATION' => "Wheeling, WV" }

    expect(response).to be_successful

    city_details = JSON.parse(response.body)

    expect(city_details).to eq({"message"=>"There are no details available for this city."})
  end

  it "If the endpoint is hit without required headers, an error message is sent" do

    get '/api/v1/urban_area/details'

    error_message = JSON.parse(response.body)

    expect(error_message).to eq({"error"=>"Missing location header", "status"=>400})
  end
end
