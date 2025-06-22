# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :role, presence: true, inclusion: { in: %w[receptionist doctor] }
  
  def receptionist?
    role == 'receptionist'
  end
  
  def doctor?
    role == 'doctor'
  end
end