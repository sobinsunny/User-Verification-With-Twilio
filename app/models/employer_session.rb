class EmployerSesssion < ActiveType::Object
  attribute :email, :string
  attribute :phone_number, :string
  validates  :email, presence: true

  def self.employer(email)
    Employer.sign_in(email)
  end
end