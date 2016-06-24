class EmployersController < ApplicationController
  before_action :load_employer, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show
  end

  def new
    build_employer
  end

  def edit
  end

  def create
    build_employer
    if @employer.save
      flash[:sucess] = 'Employer created'
      redirect_to conform_phone_number_employers_path
    else
      render :new
    end
  end

  def authenticate_email
    @employer = Employer.find_by_email_token(params[:id])
    if @employer
      if @employer.is_email_verified
        flash[:info] = 'Your Email already validated'
      else
        @employer.mark_email_as_verified
        flash[:sucess] = 'Your Email sucessfullly validated'
      end
      # session[:employer_id] = @employer.id
    else
      flash[:error] = 'Invalid Authentication'
     end
    redirect_to root_path
  end

  def authenticate_phone_number
    @employer = Employer.find_by_phone_token(params[:code])
    if @employer
      if @employer.is_phone_verified
        flash[:info] = 'Your Phone Number already validated'
      else
        @employer.mark_phone_number_as_verified
        flash[:sucess] = 'Your Phone sucessfullly validated'
      end
      # session[:employer_id] = @employer.id
    else
      flash[:error] = 'Invalid Authentication'
    end
    redirect_to root_path
  end

  def conform_phone_number
  end

  def home
  end

  def sign_in
    @employer = Employer.find_by_email(params[:email])
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

  # PATCH/PUT /employers/1
  # PATCH/PUT /employers/1.json
  def update
    respond_to do |format|
      if @employer.update(employer_params)
        format.html { redirect_to @employer, notice: 'Employer was successfully updated.' }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private

  def load_employers
    @employers ||= employers_scoped.to_a
  end

  # Use callbacks to share common setup or constraints between actions.
  def load_employer
    @employer = Employer.find(params[:id])
  end

  def build_employer
    @employer ||= Employer.new(employer_params)
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employer_params
    employer_params = params[:employer]
    employer_params.present? ? permit(:name, :email, :dob, :location, :phone_number) : {}
  end

  def employer_scoped
    Employer.scoped
  end
end
