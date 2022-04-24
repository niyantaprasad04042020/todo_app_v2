require 'rails_helper'

RSpec.describe "Users", type: :request do

  FactoryBot.define do
    factory :user do
       trait :invalid_user do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        email_id { '' }
        phone_no { '9957086386' }
        password { 'pineapple' }
      end
    end
  end

  describe "POST /signup" do
    it "signup a user" do
      headers = { "ACCEPT" => "application/json" } 
      @invalid_user  = FactoryBot.create :user, :invalid_user
      expect do
        post "/signup", :params => { :first_name => @invalid_user.first_name, :last_name => @invalid_user.last_name, :email_id => @invalid_user.email_id, :phone_no =>  @invalid_user.phone_no, :password => @invalid_user.password}, :headers => headers
      end.to change(User, :count).by(0)
    end
  end

  describe "POST /login" do
    it "login in as a user" do
      headers = { "ACCEPT" => "application/json" }
      expect do
        post "/login", :params => { :email_id => @invalid_user.email_id, :password => @invalid_user.password}, :headers => headers
      end.to change(User, :count).by(0)
    end
  end
end
