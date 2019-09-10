require "rails_helper"

describe "User Registration" do
  it "user enters Credentials correctly and is registered with the application" do
    post "/api/v1/users", headers: {
      "HTTP_FIRST_NAME" => "Patrick",
      "HTTP_LAST_NAME" => "Goulding",
      "HTTP_EMAIL" => "patrick@goulding.com",
      "HTTP_PASSWORD" => "pat_is_awesome",
      "HTTP_PASSWORD_CONFIRMATION" => "pat_is_awesome" }
    reponse_body = {
      "first_name": "Patrick",
      "last_name": "Goulding",
      "email": "patrick@goulding.com",
      "api_key": "A1234"
    }
    expect(response).to be_successful
    api_response = JSON.parse(response.body)
    expect(api_response.keys).to eq(["first_name", "last_name", "email", "api_key"])
    expect(User.last.email).to eq("patrick@goulding.com")
  end

  it "user cannot register if email already exists" do
    User.create(
      first_name: "Patrick",
      last_name: "Goulding",
      email: "patrick@goulding.com",
      password: "password",
      api_key: "A1234"
    )

    post "/api/v1/users", headers: {
      "HTTP_FIRST_NAME" => "Patrick",
      "HTTP_LAST_NAME" => "Goulding",
      "HTTP_EMAIL" => "patrick@goulding.com",
      "HTTP_PASSWORD" => "pat_is_awesome",
      "HTTP_PASSWORD_CONFIRMATION" => "pat_is_awesome" }

    reponse_body = {
      "first_name": "Patrick",
      "last_name": "Goulding",
      "email": "patrick@goulding.com",
      "api_key": "A1234"
    }

    registration_error = {"error"=>"Choose a different Email", "status"=>400}

    email_failure = JSON.parse(response.body)
    expect(email_failure).to eq(registration_error)
  end

  it "password and password confirmation must match"  do

    post "/api/v1/users", headers: {
      "HTTP_FIRST_NAME" => "Patrick",
      "HTTP_LAST_NAME" => "Goulding",
      "HTTP_EMAIL" => "patrick@goulding.com",
      "HTTP_PASSWORD" => "pat_is_awesome",
      "HTTP_PASSWORD_CONFIRMATION" => "potatoes_awesome" }

    reponse_body = {
      "first_name": "Patrick",
      "last_name": "Goulding",
      "email": "patrick@goulding.com",
      "api_key": "A1234"
    }

    password_error = {
      "error" => "Password and Password Confirmation do not match"
      }

    email_failure = JSON.parse(response.body)
    expect(email_failure).to eq(password_error)
  end
end
