# app/controllers/patients_controller.rb
class PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy]
  before_action :require_receptionist!, except: [:index, :show]
  
  def index
    @patients = Patient.all.order(created_at: :desc)
    @patients = @patients.where("name ILIKE ?", "%#{params[:search]}%") if params[:search].present?
    @patients = @patients.page(params[:page]).per(10) if defined?(Kaminari)
  end
  
  def show
  end
  
  def new
    @patient = Patient.new
  end
  
  def create
    @patient = Patient.new(patient_params)
    
    if @patient.save
      redirect_to @patient, notice: 'Patient was successfully registered.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: 'Patient was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @patient.destroy
    redirect_to patients_path, notice: 'Patient was successfully deleted.'
  end
  
  private
  
  def set_patient
    @patient = Patient.find(params[:id])
  end
  
  def patient_params
    params.require(:patient).permit(:name, :email, :phone, :address, :date_of_birth, :gender, :medical_history, :emergency_contact)
  end
end