class RemoveUnusedTables < ActiveRecord::Migration
  def change
    drop_table :roles
    drop_table :people
    drop_table :settings
  end
end
