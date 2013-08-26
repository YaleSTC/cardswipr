class Student < ActiveRecord::Base

  def self.to_csv
    columns_to_export = column_names - ["created_at", "updated_at"]
    CSV.generate do |csv|
      csv << columns_to_export
      all.each do |user|
        csv << (user.attributes.values_at(*columns_to_export))
      end
    end
  end

end
