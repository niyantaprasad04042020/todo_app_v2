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
      byebug
      @valid_user  = FactoryBot.create :user, :valid_user
      expect(UserMailer).to receive(:reset_password).once.and_return(double(deliver_now: true))
      post :create, params: { email: @valid_user.email_id }
      expect(response).to be_successful
    end

    it "should send reset password email" do
      expect(UserMailer).to_not receive(:reset_password)
      post :create, params: { email: 'non@existent.com' }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "should generate password token" do
      @valid_user.generate_token_for_password_reset!
      get :edit, params: { token: @valid_user.reset_password_token }
      expect(response).to be_successful
    end

    it "returns unauthorized for expired tokens" do
      @valid_user.generate_token_for_password_reset!
      @valid_user.update({ reset_password_token_expires_at: 2.days.ago })
      get :edit, params: { token: @valid_user.reset_password_token }
      expect(response).to have_http_status(401)
    end

    it 'returns unauthorized for invalid expirations' do
      @valid_user.generate_token_for_password_reset!
      @valid_user.update({ reset_password_token_expires_at: nil })
      get :edit, params: { token: @valid_user.reset_password_token }
      expect(response).to have_http_status(401)
    end

    it 'returns unauthorized for invalid params' do
      @valid_user.generate_token_for_password_reset!
      get :edit, params: { token: 1 }
      expect(response).to have_http_status(401)
    end
  end

  describe "PATCH #update" do
    let(:new_password) { 'new_password' }
    it do
      @valid_user.generate_token_for_password_reset!
      patch :update, params: { token: @valid_user.reset_password_token, password: new_password, password_confirmation: new_password }
      expect(response).to be_successful
    end

    it 'returns 422 if passwords do not match' do
      @valid_user.generate_token_for_password_reset!
      patch :update, params: { token: @valid_user.reset_password_token, password: new_password, password_confirmation: 1 }
      expect(response).to have_http_status(422)
    end

    it 'returns 400 if param is missing' do
      @valid_user.generate_token_for_password_reset!
      patch :update, params: { token: @valid_user.reset_password_token, password: new_password }
      expect(response).to have_http_status(400)
    end
  end
end