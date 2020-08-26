class CreateCheckIns < ActiveRecord::Migration[6.0]
  def change
    create_table :check_ins do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :net_id
      t.string :upi
      t.string :phone
      t.datetime :checked_in_at
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
