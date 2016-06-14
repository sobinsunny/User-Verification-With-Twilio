json.array!(@employers) do |employer|
  json.extract! employer, :id, :name, :email, :dob, :location, :phone_number, :phone_token, :is_email_verified, :is_phone_verified
  json.url employer_url(employer, format: :json)
end
