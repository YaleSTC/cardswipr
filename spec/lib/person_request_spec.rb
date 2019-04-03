# frozen_string_literal: true

require 'rails_helper'
require './lib/api/person_request'
require 'json'

RSpec.describe PersonRequest, type: :model do
  describe 'api functionality' do
    it 'raises error when request is empty' do
      response = file_to_response(nil, 401)
      allow(HTTParty).to receive(:get) { response }
      expect { PersonRequest.fetch('ex.com', {}) }.to raise_error(RuntimeError)
    end

    it 'raises error when HTTParty return is invalid_request.json' do
      response = file_to_response('./spec/fixtures/api/invalid_request.xml',
                                  501)
      allow(HTTParty).to receive(:get) { response }
      expect { PersonRequest.fetch('ex.com', {}) }.to raise_error(RuntimeError)
    end

    it 'raises error when HTTParty return is no_match.json' do
      response = file_to_response('./spec/fixtures/api/no_match.json', 200)
      allow(HTTParty).to receive(:get) { response }
      expect { PersonRequest.fetch('ex.com', {}) }.to raise_error(RuntimeError)
    end

    it 'returns a person object when HTTParty return is success.json' do
      response = file_to_response('./spec/fixtures/api/success.json', 200)
      allow(HTTParty).to receive(:get) { response }
      Lastname = PersonRequest.fetch('ex.com',
                                     {})['Names']['ReportingNm']['Last']
      expect(Lastname).to eq('Skywalker')
    end
  end
end
