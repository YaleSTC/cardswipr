# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com" }
    sequence(:username) { |n| "user#{n}" }
  end
end
