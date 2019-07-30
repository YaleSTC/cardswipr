class ChangeCheckInToCheckedIn < ActiveRecord::Migration[5.2]
  def change
    rename_column :attendances, :check_in, :checked_in_at
  end
end
