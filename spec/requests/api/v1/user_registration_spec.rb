require "rails_helper"

describe "User Registration" do
  it "user enters Credentials correctly and is registered with the application" do
    post "/api/v1/users", headers: { 
      "HTTP_FIRST_NAME" => "Patrick", 
      "HTTP_LAST_NAME" => "Goulding", 
      "HTTP_EMAIL" => "patrick@goulding.com", 
      "HTTP_PASSWORD" => "pat_is_awesome", 
      "HTTP_PASSWORD_CONFIRMATION" => "pat_is_awesome" }

    expect(response).to be_successful
    api_response = JSON.parse(response.body)
    expect(api_response).
  end 
end 