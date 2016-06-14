class Employer < ActiveRecord::Base
  include Authentication
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  # validates :phone_number, uniqueness:{ scope :email, message: "Already registered with this email" }

 

  

  def mark_email_as_verified
	 update!(is_email_verified: true)
  end

  def mark_phone_number_as_verified
   update!(is_phone_verified: true)
  end


end
