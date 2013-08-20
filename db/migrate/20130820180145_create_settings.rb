class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.integer :freshman_year

      t.timestamps
    end
  end
end
