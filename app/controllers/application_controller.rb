class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :login_required!, only: [:show, :index]

  private

  def login_required!
    redirect_to root_path unless current_user
  end

  def current_user
    @currnt_employer ||= Employer.find session[:employer_id] if session[:employer_id].present?
  end
end
