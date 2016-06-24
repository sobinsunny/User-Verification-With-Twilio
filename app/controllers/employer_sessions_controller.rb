class EmployerSessionsController < ApplicationController
  def sign_in
    find_employer
    if @employer.present?
      if @employer.is_authenticated_user?
        session[:employer_id] = @employer.id
        flash[:sucess] = 'Login Succesful'
        redirect_to @employer
      else
        flash[:error] = 'You are not verified Email and Phone Number'
        redirect_to root_path
      end
    else
      flash[:error] = 'Invalid Email'
      redirect_to root_path
     end
      end

  def sign_out
    @current_employer = session[:employer_id] = nil
    redirect_to root_path
    end

  def home
 end

  private

  def find_employer
    @employer ||= EmployerSession.find_employer(email)
  end
end
