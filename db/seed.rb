# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb
# Create demo users
User.create!([
  {
    name: 'John Receptionist',
    email: 'receptionist@hospital.com',
    password: 'password',
    role: 'receptionist'
  },
  {
    name: 'Dr. Sarah Smith',
    email: 'doctor@hospital.com',
    password: 'password',
    role: 'doctor'
  }
])

# Create sample patients
Patient.create!([
  {
    name: 'Alice Johnson',
    email: 'alice.johnson@email.com',
    phone: '555-0101',
    address: '123 Main St, Anytown, AN 12345',
    date_of_birth: Date.new(1985, 6, 15),
    gender: 'Female',
    medical_history: 'No significant medical history.',
    emergency_contact: '555-0102'
  },
  {
    name: 'Bob Wilson',
    email: 'bob.wilson@email.com',
    phone: '555-0201',
    address: '456 Oak Ave, Somewhere, SW 67890',
    date_of_birth: Date.new(1978, 3, 22),
    gender: 'Male',
    medical_history: 'Hypertension, managed with medication.',
    emergency_contact: '555-0202'
  },
  {
    name: 'Carol Davis',
    email: 'carol.davis@email.com',
    phone: '555-0301',
    address: '789 Pine Rd, Elsewhere, EL 54321',
    date_of_birth: Date.new(1992, 11, 8),
    gender: 'Female',
    medical_history: 'Allergic to penicillin.',
    emergency_contact: '555-0302'
  },
  {
    name: 'David Brown',
    email: 'david.brown@email.com',
    phone: '555-0401',
    address: '321 Elm St, Nowhere, NW 98765',
    date_of_birth: Date.new(1965, 9, 14),
    gender: 'Male',
    medical_history: 'Diabetes Type 2, previous heart surgery.',
    emergency_contact: '555-0402'
  },
  {
    name: 'Emma Taylor',
    email: 'emma.taylor@email.com',
    phone: '555-0501',
    address: '654 Maple Dr, Anywhere, AW 13579',
    date_of_birth: Date.new(1990, 12, 25),
    gender: 'Female',
    medical_history: 'No known allergies or medical conditions.',
    emergency_contact: '555-0502'
  }
])

puts "Created #{User.count} users and #{Patient.count} patients"

# Create patients for different dates to show chart data
# Patients registered in the last 7 days
7.times do |i|
  Patient.create!(
    name: "Patient #{i + 6}",
    email: "patient#{i + 6}@email.com",
    phone: "555-#{sprintf('%04d', 600 + i)}",
    address: "#{100 + i} Test St, City, ST 12345",
    date_of_birth: Date.new(1980 + rand(30), rand(12) + 1, rand(28) + 1),
    gender: ['Male', 'Female', 'Other'].sample,
    medical_history: "Medical history for patient #{i + 6}",
    emergency_contact: "555-#{sprintf('%04d', 700 + i)}",
    created_at: i.days.ago
  )
end

puts "Total patients created: #{Patient.count}"

## Setup Instructions

### 1. Initial Setup
```bash
# Install dependencies
bundle install

# Setup database
rails db:create
rails db:migrate
rails db:seed

# Start the server
rails server