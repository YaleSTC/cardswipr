class CreateJoinEventUser < ActiveRecord::Migration
  def change
    create_table :join_event_users do |t|
      t.references :event, :null => false
      t.references :user, :null => false
    end
  end
end
