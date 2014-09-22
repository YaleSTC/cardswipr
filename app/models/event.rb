class Event < ActiveRecord::Base

# has_and_belongs_to_many :users, as: admins
has_many :attendance_entries

#within an event, upi must be unique


  # taken from student.rb, not configured yet
  def self.to_csv
    columns_to_export = column_names - ["id", "created_at", "updated_at", "event_id"]
    #can we add back in "created_at" but rename it to "checkin time"?
    CSV.generate do |csv|
      csv << columns_to_export
      all.each do |user|
        csv << (user.attributes.values_at(*columns_to_export))
      end
    end
  end

  def last_edited
    if attendance_entries.blank?
      return ""
    else
      return attendance_entries.last.created_at.strftime("%a %b %d, %Y")
    end
  end

end
