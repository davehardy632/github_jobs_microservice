require "rails_helper"

describe User, type: :model do
  
  describe "Validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
    it {should validate_presence_of :email}
    it {should validate_presence_of :password}
    it {should validate_presence_of :api_key}
  end

end