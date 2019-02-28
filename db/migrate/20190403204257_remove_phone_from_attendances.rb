class RemovePhoneFromAttendances < ActiveRecord::Migration[5.2]
  def change
    remove_column :attendances, :phone, :string
  end
end
