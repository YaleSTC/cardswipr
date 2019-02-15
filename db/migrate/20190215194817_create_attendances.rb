class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :net_id
      t.string :upi
      t.string :phone
      t.string :check_in
      t.timestamps
    end
  end
end
