# frozen_string_literal: true

FactoryBot.define do
  factory :user_event do
    user
    event
  end
end
