class CreatePreregistrations < ActiveRecord::Migration[6.0]
  def change
    create_table :preregistrations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :net_id
      t.string :upi
      t.string :phone
      t.boolean :checked_in, default: false
      t.references :event, foreign_key: true
      t.timestamps
    end
  end
end
