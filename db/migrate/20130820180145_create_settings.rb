class CreateSettings < ActiveRecord::Migration[4.2]
  def change
    create_table :settings do |t|
      t.integer :freshman_year

      t.timestamps
    end
  end
end
