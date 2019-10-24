class AddOldIdsToTables < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :v1_id, :integer
    add_column :users, :v1_id, :integer
  end
end
