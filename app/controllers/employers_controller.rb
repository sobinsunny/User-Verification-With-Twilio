class EmployersController < ApplicationController
  before_action :set_employer, only: [:show, :edit, :update, :destroy]

  # GET /employers
  # GET /employers.json
  def index
    @employers = Employer.all
  end

  # GET /employers/1
  # GET /employers/1.json
  def show
  end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit
  end

  # POST /employers
  # POST /employers.json
  def create
    @employer = Employer.new(employer_params)
    if @employer.save
      flash[:sucess] = 'Employer created'
      redirect_to @employer
    else
      render :new
    end
  end

  def authenticate_email
    @employer = Employer.find_by_email_token(params[:id])
      if @employer
        unless @employer.is_email_verified
           @employer.mark_email_as_verified
           flash[:sucess] = 'Your Email sucessfullly validated' 
        else
           flash[:info] = 'Your Email already validated'
        end
        redirect_to @employer
     else
      flash[:error] = 'Invalid Authentication'
      redirect_to root_path
     end 
  end 

  def authenticate_phone_number
     @employer = Employer.find_by_phone_token(params[:code])
     
      if @employer
        unless @employer.is_phone_verified
           @employer.mark_phone_number_as_verified
           flash[:sucess] = 'Your Phone sucessfullly validated'
        else
           flash[:info] = 'Your Phone Number already validated'   
         end
        redirect_to @employer
     else
      flash[:error] = 'Invalid Authentication'
      redirect_to root_path
     end 

  end

  def conform_phone_number
  
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

  # Use callbacks to share common setup or constraints between actions.
  def set_employer
    @employer = Employer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employer_params
    params.require(:employer).permit(:name, :email, :dob, :location, :phone_number)
  end
end
