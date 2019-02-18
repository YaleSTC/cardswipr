class RemoveEventAttendanceTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :event_attendances

    add_reference :attendances, :event, foreign_key: true
  end
end
