# frozen_string_literal: true

require 'rails_helper'
require 'json'

RSpec.describe PeopleHub::PersonRequest do
  describe 'api functionality' do
    it 'raises error when request is empty' do
      response = file_to_response(nil, 401)
      allow(HTTParty).to receive(:get) { response }
      expect { described_class.get(netid: 'ls222') }
        .to raise_error(RuntimeError)
    end

    it 'raises error when HTTParty return is invalid_request.json' do
      response = file_to_response('./spec/fixtures/api/invalid_request.xml',
                                  501)
      allow(HTTParty).to receive(:get) { response }
      expect { described_class.get(netid: 'ls222') }
        .to raise_error(RuntimeError)
    end

    it 'raises error when HTTParty return is no_match.json' do
      response = file_to_response('./spec/fixtures/api/no_match.json', 200)
      allow(HTTParty).to receive(:get) { response }
      expect { described_class.get(netid: 'ls222') }
        .to raise_error(RuntimeError)
    end

    it 'returns a person object when HTTParty return is success.json' do
      stub_valid_response
      person = described_class.get(netid: 'ls266')
      expect(person).to be_a PeopleHub::Person
    end

    it 'allows queries with valid params' do
      stub_valid_response
      expect(described_class.get(netid: 'ls222'))
        .to be_a PeopleHub::Person
    end

    it 'does not allow queries with invalid params' do
      expect { described_class.get(wzip: '00001') }
        .to raise_error(RuntimeError)
    end

    it 'creates a PeopleHub::Person with attributes equal to filtered hash' do
      stub_valid_response
      person = described_class.get(netid: 'ls222')
      expect(person_hash(person)).to eq(filtered_hash)
    end

    def stub_valid_response
      response = file_to_response('./spec/fixtures/api/success.json', 200)
      allow(HTTParty).to receive(:get).and_return(response)
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

  describe 'fake api functionality' do
    before do
      allow(Rails.configuration).to receive(:fake_peoplehub).and_return(true)
    end

    it 'does not allow queries with invalid params' do
      expect { described_class.get(invalid_param: '00001') }
        .to raise_error(RuntimeError)
    end
    it 'allows queries with netid' do
      expect(described_class.get(netid: 'ls222'))
        .to be_a PeopleHub::FakePerson
    end
    it 'allows queries with proxnumber' do
      expect(described_class.get(proxnumber: '0123456789'))
        .to be_a PeopleHub::FakePerson
    end
  end
end
