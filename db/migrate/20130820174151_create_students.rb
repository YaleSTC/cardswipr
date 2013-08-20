class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.string :netid
      t.string :class_year
      t.integer :id_card_number
      t.integer :yale_upi

      t.timestamps
    end
  end
end
