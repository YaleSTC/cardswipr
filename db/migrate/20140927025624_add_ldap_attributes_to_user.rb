class AddLdapAttributesToUser < ActiveRecord::Migration
  def change
    add_column :users, :nickname, :string
    add_column :users, :email, :string
  end
end
