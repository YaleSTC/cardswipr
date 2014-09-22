json.array!(@event_attendance_entries) do |event_attendance_entry|
  json.extract! event_attendance_entry, :first_name, :nickname, :last_name, :upi, :netid, :email, :college_name, :college_abbreviation, :class_year, :school, :telephone, :address
  json.url event_attendance_entry_url(event_attendance_entry, format: :json)
end
