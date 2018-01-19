class RemoveUnusedTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :roles
    drop_table :people
    drop_table :settings
  end
end
