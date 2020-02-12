# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleHub::PersonRequest do
  describe '.query_peoplehub' do
    it 'initially queries a ten digit number as a proxnum' do
      search_param = '1234567890'
      stub_valid_response
      described_class.get(search_param)
      expect(PeopleHub::Querier).to have_received(:get)
        .with(proxnumber: search_param)
    end

    it 'queries for an idcard if the proxnum one fails' do
      search_param = '1234567890'
      stub_no_match_response
      # rubocop:disable Style/RescueModifier
      described_class.get(search_param) rescue nil
      # rubocop:enable Style/RescueModifier
      expect(PeopleHub::Querier).to have_received(:get)
        .with(idcard: search_param)
    end

    it 'queries for a netid when given a string with a letter in it' do
      search_param = 'a'
      stub_valid_response
      described_class.get(search_param)
      expect(PeopleHub::Querier).to have_received(:get)
        .with(netid: search_param)
    end

    it 'raises an error when nothing matches' do
      search_param = '1'
      expect { described_class.get(search_param) }.to \
        raise_error('Invalid Input')
    end
  end

  describe 'response_to_person functionality' do
    it 'raises error when request is empty' do
      response = file_to_response(nil, 401)
      allow(PeopleHub::Querier).to receive(:get) { response }
      expect { described_class.get('ls222') }
        .to raise_error(RuntimeError)
    end

    it 'raises error when HTTParty return is no_match.json' do
      stub_no_match_response
      expect { described_class.get('ls222') }
        .to raise_error(RuntimeError)
    end

    it 'returns a PeopleHub::Person object' do
      stub_valid_response
      person = described_class.get('ls266')
      expect(person).to be_a PeopleHub::Person
    end

    it 'creates a PeopleHub::Person with attributes equal to filtered hash' do
      stub_valid_response
      person = described_class.get('ls222')
      expect(person_hash(person)).to eq(filtered_hash)
    end
  end

  describe 'fake api functionality' do
    before do
      allow(Rails.configuration).to receive(:fake_peoplehub).and_return(true)
    end

    it 'does not allow queries with invalid params' do
      expect { described_class.get('00001') }
        .to raise_error(RuntimeError)
    end
    it 'allows queries with netid' do
      expect(described_class.get('ls222'))
        .to be_a PeopleHub::FakePerson
    end
    it 'allows queries with proxnumber' do
      expect(described_class.get('0123456789'))
        .to be_a PeopleHub::FakePerson
    end
  end

  def stub_valid_response
    response = file_to_response('./spec/fixtures/api/success.json', 200)
    allow(PeopleHub::Querier).to receive(:get).and_return(response)
  end

  def stub_no_match_response
    response = file_to_response('./spec/fixtures/api/no_match.json', 200)
    allow(PeopleHub::Querier).to receive(:get) { response }
  end

  def person_hash(person)
    person.instance_variables.each.with_object({}) do |attr, hash|
      hash[attr[1..-1].to_sym] = person.instance_variable_get(attr)
    end
  end

  def filtered_hash
    { first_name: 'Luke', last_name: 'Skywalker',
      email: 'luke.skywalker@mail.com', net_id: 'ls222', upi: '12345678',
      phone: '+1 (555) 555-5555' }
  end
end
