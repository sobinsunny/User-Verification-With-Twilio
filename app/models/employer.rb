class Employer < ActiveRecord::Base
  before_create :send_verifications

  before_create :generate_phone_verification_code

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true
  # validates :phone_number, uniqueness:{ scope :email, message: "Already registered with this email" }

  def send_verifications
    self.email_token = SecureRandom.urlsafe_base64.to_s
  end

  def self.verify_email_token(tocken)
  		#todo
  		employer = Employer.find_by_email_token(tocken)
  		if employer
  			employer.update_attribute('is_email_verified',true)
  		end
  		employer
  end

  def generate_phone_verification_code
    begin
     self.phone_tocken = SecureRandom.hex(3)
    end while self.class.exists?(phone_verification_code: verification_code)
    verification_code
     send_sms
  end


   def from
     number = '207 518-7503' 
  end

  def to
    # +1 is a country code for USA
    "+91#{self.phone_number}"
  end

  def body
    "Please reply with this code '#{self.phone_token}' to
    verify your phone number"
  end


 def send_sms
 	@twilio = Twilio::REST::Client.new('AC8a1674c800f16e93dd849dc98f8ddf1c','5c97af30fbf04176edecc77ce40fd7c5')

    Rails.logger.info "SMS: From: #{from} To: #{to} Body: \"#{body}\""
    @twilio.account.messages.create({
      from:'+12075187503',
      to: to,
      body: body
   })
  end

end
