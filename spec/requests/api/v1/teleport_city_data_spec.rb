require 'rails_helper'

describe "Teleport api" do
  it "A user can get data about a given city" do

    get '/api/v1/city_data', headers: { 'HTTP_LOCATION' => "Denver, CO" }

    expect(response).to be_successful

    city_info = JSON.parse(response.body)

    expect(city_info.length).to eq(3)
  end
end
