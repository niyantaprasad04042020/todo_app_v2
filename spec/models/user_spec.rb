require 'rails_helper'

RSpec.describe User, type: :model do
  FactoryBot.define do
    factory :user do
      trait :valid_user do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        email_id { 'niyanta16@gmail.com' }
        phone { '9957086386' }
        password { "pineapple" }
      end

      trait :invalid_first_name do
        first_name { '' }
        last_name { 'Prasad' }
        email_id { 'niyanta16@gmail.com' }
        phone { '9957086386' }
        password { "pineapple" }
      end

      trait :invalid_first_name_length do
        first_name { 'N' }
        last_name { 'Prasad' }
        email_id { 'niyanta16@gmail.com' }
        phone { '9957086386' }
        password { "pineapple" }
      end

      trait :invalid_last_name do
        first_name { 'Niyanta' }
        last_name { '' }
        email_id { 'niyanta16@gmail.com' }
        phone { '9957086386' }
        password { 'pineapple' }
      end

      trait :invalid_last_name_ength do
        first_name { 'Niyanta' }
        last_name { 'P' }
        email_id { 'niyanta16@gmail.com' }
        phone { '9957086386' }
        password { 'pineapple' }
      end

      trait :invalid_email_id do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        email_id { '' }
        phone { '9957086386' }
        password { 'pineapple' }
      end

      trait :invalid_phone_no do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        email_id { 'niyanta16@gmail.com' }
        phone { '' }
        password { 'pineapple' }
      end

      trait :invalid_password do
        first_name { 'Niyanta' }
        last_name { 'Prasad' }
        email_id { 'niyanta16@gmail.com' }
        phone { '9957086386' }
        password { '' }
      end
    end
  end

  it 'validates presence of first name' do
  	byebug
  	@invalid_first_name   = FactoryBot.create :user, :invalid_first_name
    expect(@invalid_first_name).to_not be_valid
  end

  it 'validates presence of last name' do
    @invalid_last_name    = FactoryBot.create :user, :invalid_last_name
    expect(@invalid_last_name).to_not be_valid
  end

  it 'validates presence of email id' do
    @invalid_email_id     = FactoryBot.create :user, :invalid_email_id
    expect(@invalid_email_id).to_not be_valid
  end

  it 'validates presence of phone no' do
    @invalid_phone_no     = FactoryBot.create :user, :invalid_phone_no
    expect(@invalid_last_name).to_not be_valid
  end

  it 'validates presence of password' do
    @invalid_password     = FactoryBot.create :user, :invalid_password
    expect(@invalid_password).to_not be_valid
  end

  it 'validates length of firstname' do
    @invalid_first_name_length   = FactoryBot.create :user, :invalid_first_name_length
    expect(@invalid_first_name_length).to_not be_valid
  end

  it 'validates length of lastname' do
    @invalid_last_name_length    = FactoryBot.create :user, :invalid_last_name_length
    expect(@invalid_last_name_length).to_not be_valid
  end

  it 'validates user' do
    @valid_user         = FactoryBot.create :user, :valid_user
    expect(@valid_user).to be_valid
  end
end
