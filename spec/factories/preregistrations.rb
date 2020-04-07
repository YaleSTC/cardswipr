# frozen_string_literal: true

FactoryBot.define do
  factory :preregistration do
    sequence(:first_name) { |n| "user#{n}" }
    sequence(:last_name) { |n| "last#{n}" }
    sequence(:email) { |n| "email#{n}@email.com" }
    net_id { 'abc123' }
    upi { '01234567' }
    phone { '555-555-5555' }
    checked_in { false }
    event
  end
end
