# app/models/patient.rb
class Patient < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :date_of_birth, presence: true
  validates :gender, presence: true, inclusion: { in: %w[Male Female Other] }
  
  scope :registered_today, -> { where(created_at: Date.current.beginning_of_day..Date.current.end_of_day) }
  scope :registered_this_week, -> { where(created_at: 1.week.ago..Time.current) }
  scope :registered_this_month, -> { where(created_at: 1.month.ago..Time.current) }
  
  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end
end