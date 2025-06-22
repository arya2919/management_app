# db/migrate/002_create_patients.rb
class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :phone, null: false
      t.text :address, null: false
      t.date :date_of_birth, null: false
      t.string :gender, null: false
      t.text :medical_history
      t.string :emergency_contact
      
      t.timestamps
    end
    
    add_index :patients, :email, unique: true
    add_index :patients, :created_at
  end
end