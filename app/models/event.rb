class Event < ActiveRecord::Base

# has_and_belongs_to_many :users, as: admins
has_many :event_attendance_entries

#within an event, upi must be unique


  # taken from student.rb, not configured yet
  def self.to_csv
    columns_to_export = column_names - ["created_at", "updated_at"]
    #can we add back in "created_at" but rename it to "checkin time"?
    CSV.generate do |csv|
      csv << columns_to_export
      all.each do |user|
        csv << (user.attributes.values_at(*columns_to_export))
      end
    end
  end

end
