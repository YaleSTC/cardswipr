class AddPreregistrationBoolToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :preregistration, :boolean, default: false
  end
end
