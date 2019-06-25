class DropStudentsTable < ActiveRecord::Migration[4.2]
  def change
    drop_table :students
  end
end
