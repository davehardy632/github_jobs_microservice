require 'rails_helper'
require 'webmock/rspec'

describe "Teleport api" do
  before :each do
    WebMock.disable!
  end
  it "A user can get data about a given city" do

    get '/api/v1/urban_area/images', headers: { 'HTTP_LOCATION' => "Denver, CO" }

    expect(response).to be_successful

    city_images = JSON.parse(response.body)

    expect(city_images.length).to eq(2)
    expect(city_images.keys).to eq(["mobile", "web"])
  end

  it "Returns an explanation if the given city has no images due to lack of urban area relation" do

    get '/api/v1/urban_area/images', headers: { 'HTTP_LOCATION' => "Wheeling, WV" }

    expect(response).to be_successful

    city_images = JSON.parse(response.body)

    expect(city_images).to eq({"message"=>"There are no images available for this city."})

  end
end
