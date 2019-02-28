# frozen_string_literal: true

FactoryBot.define do
  factory :attendance do
    sequence(:first_name) { |n| "user#{n}" }
    sequence(:last_name) { |n| "last#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    net_id { 'abc123' }
    upi { '01234567' }
    check_in { Time.zone.now }
    event
  end
end
