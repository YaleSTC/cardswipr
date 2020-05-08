# frozen_string_literal: true

require 'ffaker'

module PeopleHub
  # class for mocking PeopleHub person
  # if net_id is nil, creates a fake netid
  class FakePerson < Person
    def initialize(net_id = nil)
      @first_name = FFaker::Name.first_name
      @last_name = FFaker::Name.last_name
      @email = FFaker::Internet.safe_email
      @net_id = net_id || fake_netid
      @upi = Array.new(8) { rand(10) }.join
      @phone = FFaker::PhoneNumber.short_phone_number
    end

    def fake_netid
      "#{[*'a'..'z'].sample([2, 3].sample).join}#{rand(1..9999)}"
    end
  end
end
