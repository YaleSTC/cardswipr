class DropAttendanceTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :attendances
  end
end
