class EmployerMailer < ApplicationMailer
  default from: 'sobinedu@gmail.com'
  layout 'mailer'

  def conform_registration(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end
end
