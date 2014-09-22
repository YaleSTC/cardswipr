class CreateEventAttendanceEntries < ActiveRecord::Migration
  def change
    create_table :event_attendance_entries do |t|
      t.string :first_name
      t.string :nickname
      t.string :last_name
      t.integer :upi
      t.string :netid
      t.string :email
      t.string :college_name
      t.string :college_abbreviation
      t.integer :class_year
      t.string :school
      t.string :telephone
      t.string :address

      t.timestamps
    end
  end
end
