# Read about factories at https://github.com/thoughtbot/factory_bot

FactoryBot.define do
  factory :attendance_entry do
    event
    upi '2'
    netid 'frodo'
    first_name 'Frodo'
    last_name 'Baggins'
  end
end
