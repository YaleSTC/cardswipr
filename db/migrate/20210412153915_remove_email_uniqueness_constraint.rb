class RemoveEmailUniquenessConstraint < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :email

    change_column :users, :email, :string, null: true, default: ''
  end
end
