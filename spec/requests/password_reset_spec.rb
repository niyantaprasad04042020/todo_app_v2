require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  FactoryBot.define do
    factory :user do
       trait :valid_user do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        email_id { 'niyanta16@gmail.com' }
        phone_no { '9957086386' }
        password { 'pineapple' }
      end
    end
  end

  describe "POST #create" do

    it "should send reset password email" do
      headers = { "ACCEPT" => "application/json" }
      expect(UserMailer).to_not receive(:reset_password)
      post "/password_reset", params: { email_id: 'non@existent.com' }, :headers => headers
      expect(response).to have_http_status(401)
    end
  end

  describe "GET #edit" do

    it "returns unauthorized for expired tokens" do
      headers = { "ACCEPT" => "application/json" }
      @valid_user  = FactoryBot.create :user, :valid_user
      @valid_user.generate_token_for_password_reset!
      @valid_user.update({ reset_password_token_expires_at: 2.days.ago })
      get "/password_reset/edit" , params: { user: @valid_user, token: @valid_user.reset_password_token }, :headers => headers
      expect(response).to have_http_status(401)
    end

    it 'returns unauthorized for invalid expirations' do
      headers = { "ACCEPT" => "application/json" }
      @valid_user  = FactoryBot.create :user, :valid_user
      @valid_user.generate_token_for_password_reset!
      @valid_user.update({ reset_password_token_expires_at: nil })
      get "/password_reset/edit" , params: { token: @valid_user.reset_password_token }, :headers => headers
      expect(response).to have_http_status(401)
    end

    it "returns unauthorized for invalid params" do
      headers = { "ACCEPT" => "application/json" }
      @valid_user  = FactoryBot.create :user, :valid_user
      @valid_user.generate_token_for_password_reset!
      get "/password_reset/edit" , params: { token: 1 }, :headers => headers
      expect(response).to have_http_status(401)
    end
  end

  describe "PATCH #update" do
    let(:new_password) { 'new_password' }

    it 'returns 422 if passwords do not match' do
      headers = { "ACCEPT" => "application/json" }
      @valid_user  = FactoryBot.create :user, :valid_user
      @valid_user.generate_token_for_password_reset!
      patch "/password_reset/update", params: { token: @valid_user.reset_password_token, password: new_password, password_confirmation: 1 }
      expect(response).to have_http_status(401)
    end

    it 'returns 400 if param is missing' do
      headers = { "ACCEPT" => "application/json" }
      @valid_user  = FactoryBot.create :user, :valid_user
      @valid_user.generate_token_for_password_reset!
      patch "/password_reset/update", params: { token: @valid_user.reset_password_token, password: new_password }
      expect(response).to have_http_status(401)
    end
  end
end