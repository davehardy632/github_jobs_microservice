class User < ApplicationRecord 
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates_presence_of :password
  validates_presence_of :api_key
end