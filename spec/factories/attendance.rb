# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    sequence(:first_name) { |n| "user#{n}" }
    sequence(:last_name) { |n| "last#{n}" }
    email { 'email@email.com' }
    net_id { 'abc123' }
    upi { '01234567' }
    phone { '555-555-5555' }
    check_in { Time.zone.now }
  end
end
