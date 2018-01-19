class AddLdapAttributesToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :nickname, :string
    add_column :users, :email, :string
  end
end
