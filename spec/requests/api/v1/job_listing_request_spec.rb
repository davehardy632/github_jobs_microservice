require 'rails_helper'

describe "Jooble Job listings api" do
  it "Returns Job listings for a location and keyword" do

    get '/api/v1/listings?keywords=developer&location=portland&radius=50&salary=75000&page=2'

    expect(response).to be_successful

    listing_data = JSON.parse(response.body)
    job_keys = ["title", "location", "snippet", "salary", "source", "type", "link", "company", "updated", "id"]

    expect(listing_data["data"]["attributes"]["return_all_listings"]["jobs"].count).to eq(20)
    expect(listing_data["data"]["attributes"]["return_all_listings"]["jobs"][0].keys[0]).to eq("title")
    expect(listing_data["data"]["attributes"]["return_all_listings"]["jobs"][0].keys[1]).to eq("location")
    expect(listing_data["data"]["attributes"]["return_all_listings"]["jobs"][0].keys[2]).to eq("snippet")
    expect(listing_data["data"]["attributes"]["return_all_listings"]["jobs"][0].keys[3]).to eq("salary")
  end

  it "Returns Job listings for just a location" do

    get '/api/v1/listings?location=portland'

    expect(response).to be_successful

    listing_data = JSON.parse(response.body)

    expect(listing_data["data"]["attributes"]["return_all_listings"]["jobs"].count).to eq(20)
  end

  it "Returns error message for missing required parameter" do

    get '/api/v1/listings?radius=50'

    error_message = JSON.parse(response.body)

    expect(error_message).to eq({"error"=>"Missing required parameters", "status"=>400})
  end

  it "Returns error message for missing required parameter" do

    get '/api/v1/listings?salary=50'

    error_message = JSON.parse(response.body)

    expect(error_message).to eq({"error"=>"Missing required parameters", "status"=>400})
  end

  it "Returns a response for just the keyword parameter" do

    get '/api/v1/listings?keyword=manager'

    listing_data = JSON.parse(response.body)

    expect(listing_data["data"]["attributes"]["return_all_listings"]["jobs"].count).to eq(20)
  end
end
