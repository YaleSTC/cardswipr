class AddCurriculumOrganizationToAttendanceEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :attendance_entries, :organization, :string
    add_column :attendance_entries, :curriculum, :string
  end
end
