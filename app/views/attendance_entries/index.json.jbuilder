json.array!(@attendance_entries) do |attendance_entry|
  json.extract! attendance_entry, :first_name, :nickname, :last_name, :upi, :netid, :email, :college_name, :college_abbreviation, :class_year, :school, :telephone, :address
  json.url event_attendance_entry_url(event_attendance_entry, format: :json)
end
