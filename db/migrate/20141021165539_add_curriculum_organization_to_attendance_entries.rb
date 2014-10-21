class AddCurriculumOrganizationToAttendanceEntries < ActiveRecord::Migration
  def change
    add_column :attendance_entries, :organization, :string
    add_column :attendance_entries, :curriculum, :string
  end
end
