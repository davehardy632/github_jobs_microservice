require 'rails_helper'

describe "Jooble Job listings api" do
  before :each do

    json_listing_response = File.open("./fixtures/jooble_denver_listing_data.json")
    json_vet_listings_response = File.open("./fixtures/jooble_veternarian_listing_data.json")
    json_manager_listings_response = File.open("./fixtures/jooble_manager_listing_data.json")

    stub_request(:post, "https://us.jooble.org/api/#{ENV['JOOBLE_API_KEY']}").
        with(
          body: "{\"location\":\"Denver, CO\"}",
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'Location'=>'Denver, CO',
         'User-Agent'=>'Faraday v0.15.4'
          }).
        to_return(status: 200, body: json_listing_response, headers: {})

      stub_request(:post, "https://us.jooble.org/api/#{ENV['JOOBLE_API_KEY']}?location=Denver,%20CO").
        with(
          headers: {
         'Accept'=>'*/*',
         'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
         'User-Agent'=>'Faraday v0.15.4'
          })

    stub_request(:post, "https://us.jooble.org/api/#{ENV['JOOBLE_API_KEY']}").
      with(
        body: "{\"keywords\":\"Veternarian\"}",
        headers: {
       'Accept'=>'*/*',
       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       'Keywords'=>'Veternarian',
       'User-Agent'=>'Faraday v0.15.4'
        }).
        to_return(status: 200, body: json_vet_listings_response, headers: {})

    stub_request(:post, "https://us.jooble.org/api/#{ENV["JOOBLE_API_KEY"]}?keywords=Veternarian").
       with(
         headers: {
     	  'Accept'=>'*/*',
     	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     	  'User-Agent'=>'Faraday v0.15.4'
         })

         stub_request(:post, "https://us.jooble.org/api/#{ENV["JOOBLE_API_KEY"]}").
             with(
               body: "{\"keywords\":\"manager\"}",
               headers: {
           	  'Accept'=>'*/*',
           	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           	  'Keywords'=>'manager',
           	  'User-Agent'=>'Faraday v0.15.4'
               }).
             to_return(status: 200, body: json_manager_listings_response, headers: {})

           stub_request(:post, "https://us.jooble.org/api/#{ENV["JOOBLE_API_KEY"]}?keywords=manager").
             with(
               headers: {
           	  'Accept'=>'*/*',
           	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
           	  'User-Agent'=>'Faraday v0.15.4'
               })


  end
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

  it "Returns a response for just the keyword parameter" do

    get '/api/v1/listings', headers: { 'HTTP_KEYWORDS' => "Veternarian" }

    expect(response).to be_successful

    listing_data = JSON.parse(response.body)

    job_keys = ["title", "location", "snippet", "salary", "source", "type", "link", "company", "updated", "id"]

    expect(listing_data["jobs"].count).to eq(7)
    expect(listing_data["jobs"][0].keys).to eq(job_keys)
  end
end
