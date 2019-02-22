# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleHub::Person do
  it 'can turn a full hash into a PeopleHub::Person object' do
    person = described_class.create_person(full_hash: full_hash)
    expect(person).to be_a described_class
  end
  it 'can turn a filtered hash into a PeopleHub::Person object' do
    person = described_class.new(filtered_hash)
    expect(person).to be_a described_class
  end
  it 'creates a PeopleHub::Person with attributes equal to filtered hash' do
    person = described_class.create_person(full_hash: full_hash)
    expect(person_hash(person)).to eq(filtered_hash)
  end

  def filtered_hash
    { first_name: 'Luke', last_name: 'Skywalker',
      email: 'luke.skywalker@mail.com', net_id: 'ls222', upi: '12345678',
      phone: '+1 (555) 555-5555' }
  end

  def full_hash
    response = file_to_response('./spec/fixtures/api/success.json', 200)
    response.parsed_response['People']['Person']
  end

  def person_hash(person)
    person.instance_variables.each.with_object({}) do |attr, hash|
      hash[attr[1..-1].to_sym] = person.instance_variable_get(attr)
    end
  end
end
