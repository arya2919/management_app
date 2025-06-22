# app/controllers/dashboard_controller.rb
class DashboardController < ApplicationController
  def index
    if receptionist?
      @patients_count = Patient.count
      @today_registrations = Patient.registered_today.count
      @recent_patients = Patient.order(created_at: :desc).limit(5)
    elsif doctor?
      @total_patients = Patient.count
      @today_registrations = Patient.registered_today.count
      @weekly_data = prepare_weekly_chart_data
      @monthly_data = prepare_monthly_chart_data
    end
  end
  
  private
  
  def prepare_weekly_chart_data
    data = {}
    7.days.ago.to_date.upto(Date.current) do |date|
      count = Patient.where(created_at: date.beginning_of_day..date.end_of_day).count
      data[date.strftime('%a')] = count
    end
    data
  end
  
  def prepare_monthly_chart_data
    data = {}
    30.days.ago.to_date.upto(Date.current) do |date|
      count = Patient.where(created_at: date.beginning_of_day..date.end_of_day).count
      data[date.strftime('%m/%d')] = count
    end
    data
  end
end