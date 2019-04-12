# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    sequence(:title) { |n| "event#{n}" }
    description { 'Test Event' }

    factory :event_with_attendances do
      transient do
        attendances_count { 5 }
      end

      after(:create) do |event, evaluator|
        create_list(:attendance, evaluator.attendances_count, event: event)
      end
    end
  end
end
