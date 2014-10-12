class AddCheckedInToAttendanceEntry < ActiveRecord::Migration
  def change
    # all old data should be set to true, but the safer default for the future is false
    add_column :attendance_entries, :checked_in, :boolean, :default => true
    change_column_default :attendance_entries, :checked_in, false
  end
end
