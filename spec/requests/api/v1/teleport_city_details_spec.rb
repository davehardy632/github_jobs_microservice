require 'rails_helper'

describe "Teleport api" do
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
end
