# frozen_string_literal: true

require 'ffaker'

module PeopleHub
  # class for mocking PeopleHub person
  class FakePerson < Person
    def initialize
      @first_name = FFaker::Name.first_name
      @last_name = FFaker::Name.last_name
      @email = FFaker::Internet.safe_email
      @net_id = "#{[*'a'..'z'].sample([2, 3].sample).join}#{rand(1..9999)}"
      @upi = Array.new(8) { rand(10) }.join
      @phone = FFaker::PhoneNumber.short_phone_number
    end
  end
end
