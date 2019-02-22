class ChangeCheckInToDatetimeInAttendances < ActiveRecord::Migration[5.2]
  def change
  	remove_column :attendances, :check_in
  	add_column :attendances, :check_in, :datetime
  end
end
