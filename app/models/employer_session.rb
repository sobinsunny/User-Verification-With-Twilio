class EmployerSesssion < ActiveType::Object
  attributes :email, :string
  atrributes :phone_number, :string
  validate   :email, presence: true, message: 'Email Required'

  def self.employer(email)
    Employer.sign_in(email)
  end
end
