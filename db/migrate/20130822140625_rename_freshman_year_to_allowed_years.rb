class RenameFreshmanYearToAllowedYears < ActiveRecord::Migration[4.2]
  def change
    rename_column :settings, :freshman_year, :allowed_years
    change_column :settings, :allowed_years, :string
  end
end
