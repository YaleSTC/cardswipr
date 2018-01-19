class CreateJoinEventUser < ActiveRecord::Migration[4.2]
  def change
    create_table :events_users do |t|
      t.references :event, :null => false
      t.references :user, :null => false
    end
  end
end
