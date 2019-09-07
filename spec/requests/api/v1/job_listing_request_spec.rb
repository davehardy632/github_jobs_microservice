require 'rails_helper'

describe "Jooble Job listings api" do
  it "Returns Job listings for a location and keyword" do

    get '/api/v1/listings', headers: { 'HTTP_LOCATION' => "Denver, CO" }

    expect(response).to be_successful

    listing_data = JSON.parse(response.body)

    job_keys = ["title", "location", "snippet", "salary", "source", "type", "link", "company", "updated", "id"]

    expect(listing_data["jobs"].count).to eq(20)
    expect(listing_data["jobs"][0].keys).to eq(job_keys)
  end

  it "Returns error message for missing required parameter" do

    get '/api/v1/listings', headers: { 'HTTP_RADIUS' => "20" }

    error_message = JSON.parse(response.body)

    expect(error_message).to eq({"error"=>"Missing required headers", "status"=>400})
  end

  it "Returns error message for missing required parameter" do

    get '/api/v1/listings', headers: { 'HTTP_SALARY' => "50" }

    error_message = JSON.parse(response.body)

    expect(error_message).to eq({"error"=>"Missing required headers", "status"=>400})
  end

  it "Returns a response for just the keyword parameter" do

    get '/api/v1/listings', headers: { 'HTTP_KEYWORDS' => "manager" }

    expect(response).to be_successful

    listing_data = JSON.parse(response.body)

    job_keys = ["title", "location", "snippet", "salary", "source", "type", "link", "company", "updated", "id"]

    expect(listing_data["jobs"].count).to eq(20)
    expect(listing_data["jobs"][0].keys).to eq(job_keys)
  end
end
