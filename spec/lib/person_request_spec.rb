# frozen_string_literal: true

require 'rails_helper'
require './lib/api/person_request'
require 'json'

<<<<<<< HEAD
=======
def file_to_response(filename, code_num)
  unless filename.nil?
    file = File.read(filename)
    data = JSON.parse(file)
  end
  instance_double('response',
                  response: instance_double('child_response', code: code_num),
                  parsed_response: data)
end

>>>>>>> Solves issue 138, providing a rudimentary api for fetching Person data from an arbitrary endpoint, and returning it as a person object.
RSpec.describe PersonRequest, type: :model do
  describe 'api functionality' do
    it 'raises error when request is empty' do
      response = file_to_response(nil, 401)
      allow(HTTParty).to receive(:get) { response }
      expect { PersonRequest.fetch('ex.com', {}) }.to raise_error(RuntimeError)
    end

    it 'raises error when HTTParty return is invalid_request.json' do
<<<<<<< HEAD
      response = file_to_response('./spec/fixtures/api/invalid_request.xml',
=======
      response = file_to_response('./spec/fixtures/api/invalid_request.json',
>>>>>>> Solves issue 138, providing a rudimentary api for fetching Person data from an arbitrary endpoint, and returning it as a person object.
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
<<<<<<< HEAD
      expect(Lastname).to eq('Skywalker')
=======
      expect(Lastname).to eq('Lastname')
>>>>>>> Solves issue 138, providing a rudimentary api for fetching Person data from an arbitrary endpoint, and returning it as a person object.
    end
  end
end
