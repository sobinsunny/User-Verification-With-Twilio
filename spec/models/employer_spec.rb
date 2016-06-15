require 'rails_helper'

RSpec.describe Employer, type: :model do
  before(:all) do
    @employer = Employer.new(name: 'test name', email: 'test1@gmail.com', dob: Date.today, phone_number: '1234567890', location: 'TestLoc')
  end
  it 'it should be empty initily ', skip_before: true do
    expect(Employer.count).to eq 0
  end

  it 'has one record', skip_before: true do
    Employer.create!(name: 'test name', email: 'test@gmail.com', dob: Date.today, phone_number: '1234567890', location: 'TestLoc')
    expect(Employer.count).to eq 1
  end

  it 'should set tocken flag false' do
    expect(@employer.is_email_verified).to eq(false)
    expect(@employer.is_phone_verified).to eq(false)
  end
  it 'should create email token after create' do
    @employer.save
    expect(@employer.email_token).not_to eq(nil)
  end

  it 'should create Phone token after create' do
    @employer.save
    expect(@employer.phone_token).not_to eq(nil)
  end

  it 'raise an email email validation error', skip_before: true do
    employer = Employer.new(name: 'test name', email: '@gmail.com', dob: Date.today, phone_number: '1234567890', location: 'TestLoc')
    employer.valid?
    expect(employer.errors.full_messages).to include('Email is invalid')
  end
  it 'should update email flag after update token' do
    @employer.save
    expect(@employer.is_email_verified).not_to eq(nil)
  end
   it 'should add  email after save' do
    @employer.save
    expect(@employer.email_token).not_to eq(nil)
  end
   it 'should add phone token after save' do
    @employer.save
    expect(@employer.phone_token).not_to eq(nil)
  end
end
