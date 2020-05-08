# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleHub::FakePerson do
  it 'has the same attributes as a PeopleHub::Person object' do
    person = PeopleHub::Person.new(person_params)
    fake_person = described_class.new
    person.instance_variables.each do |attr|
      expect(fake_person.instance_variable_get(attr)).not_to eq(nil)
    end
  end
  it 'when given a netid, returns a person with that netid' do
    netid = 'netid1'
    fake_person = described_class.new(netid)
    expect(fake_person.net_id).to eq(netid)
  end

  def person_params
    { first_name: 'Luke', last_name: 'Skywalker',
      email: 'luke.skywalker@mail.com', net_id: 'ls222', upi: '12345678',
      phone: '+1 (555) 555-5555' }
  end
end
