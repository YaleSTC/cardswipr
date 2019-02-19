# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com" }
    sequence(:username) { |n| "user#{n}" }

    factory :user_with_events do
      transient do
        event_count { 5 }
      end

      after(:create) do |user, evaluator|
        create_list(:user_event, evaluator.event_count, user: user)
      end
    end
  end
end
