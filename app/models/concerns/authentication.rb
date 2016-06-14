module Authentication
  extend ActiveSupport::Concern

  included do
     before_save :generate_verifications_tokens
     after_save  :sent_verifications
  end

   def generate_verifications_tokens
	   generate_email_token if email.present? && email_changed?
	   generate_phone_token if phone_number.present? && phone_number_changed?
   end

  def generate_email_token
  	begin
	   self.email_token = SecureRandom.urlsafe_base64.to_s 
	end while self.class.exists?(email_token: self.email_token)
  end

  def generate_phone_token
	    begin
	     self.phone_token = SecureRandom.hex(3)
	    end while self.class.exists?(phone_token: self.phone_token)
  end

  def sent_verifications
   sent_email_verification if email.present? && email_changed?
   sent_phone_number_verifications if phone_number.present? && phone_number_changed?
  end


  def from
     number = '207 518-7503' 
  end

  def to
    # with country code 
    self.phone_number
  end

  def body
    "Please Use this code '#{self.phone_token}' to
     verify your phone number"
  end


	def sent_phone_number_verifications

	 	@twilio = Twilio::REST::Client.new(ENV['TWILO_SID'],ENV['TWILIO_SECRET_KEY'])
	 	begin 
		    @twilio.account.messages.create({
		      from:from,
		      to: from,
		      body: body
		   })
	    rescue Twilio::REST::RequestError => e

		end
	end


	def sent_verifications
		begin
	  	 EmployerMailer.conform_registration(self).deliver_now
	    rescue Exception => e

	    end
	end
end