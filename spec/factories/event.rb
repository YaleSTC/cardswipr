# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "event#{n}" }
    description { 'Test Event' }
  end
end
