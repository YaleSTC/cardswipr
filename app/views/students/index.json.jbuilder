json.array!(@students) do |student|
  json.extract! student, :first_name, :last_name, :netid, :class_year, :id_card_number, :yale_upi
  json.url student_url(student, format: :json)
end
