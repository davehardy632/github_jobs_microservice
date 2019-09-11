require "rails_helper"

describe "User Login" do
  before :each do 
    WebMock.disable!
  end

  it "user enters correct email and password and gets back an api key" do

    User.create(
      first_name: "Patrick",
      last_name: "Goulding",
      email: "patrick@goulding.com",
      password: "password",
      api_key: "A1234"
    )

    post "/api/v1/sessions", headers: {
      "HTTP_EMAIL" => "patrick@goulding.com",
      "HTTP_PASSWORD" => "password" }

    reponse_body = {
      "first_name": "Patrick",
      "last_name": "Goulding",
      "email": "patrick@goulding.com",
      "api_key": "A1234"
    }
    expect(response).to be_successful
    api_response = JSON.parse(response.body)
    expect(api_response.keys).to eq([
      "first_name",
      "last_name",
      "email",
      "api_key"])

    expect(User.last.email).to eq("patrick@goulding.com")
  end

  it "if user does not exist, throw an error" do

    post "/api/v1/sessions", headers: {
      "HTTP_EMAIL" => "patrick@goulding.com",
      "HTTP_PASSWORD" => "password" }

    reponse_body = {
      "error"=>"Please create an account to login"
    }

    api_response = JSON.parse(response.body)
    expect(api_response).to eq(reponse_body)
  end

  it "if user enters wrong passowrd but account exists, it throws an error" do
     User.create(
      first_name: "Patrick",
      last_name: "Goulding",
      email: "patrick@goulding.com",
      password: "password",
      api_key: "A1234"
    )

    post "/api/v1/sessions", headers: {
      "HTTP_EMAIL" => "patrick@goulding.com",
      "HTTP_PASSWORD" => "WRONGGGGGGGGG!!!!" }

    reponse_body = {
      "error" => "Invalid Credentials"
    }
    api_response = JSON.parse(response.body)
    expect(api_response).to eq(reponse_body)

    expect(User.last.email).to eq("patrick@goulding.com")
  end

  it "if the user is missing required headers it should throw an error" do
     User.create(
      first_name: "Patrick",
      last_name: "Goulding",
      email: "patrick@goulding.com",
      password: "password",
      api_key: "A1234"
    )

    post "/api/v1/sessions", headers: {
      "HTTP_PASSWORD" => "password" }

    reponse_body = {
      "error" => "Invalid Headers"
    }
    api_response = JSON.parse(response.body)
    expect(api_response).to eq(reponse_body)
  end
end
