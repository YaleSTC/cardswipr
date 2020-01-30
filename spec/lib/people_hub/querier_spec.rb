# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleHub::Querier do
  it 'allows queries with valid params' do
    stub_valid_response
    described_class.get(netid: 'ls222')
    expect(HTTParty).to have_received(:get)
  end

  describe 'HTTParty interaction' do
    let(:username) { ENV['IDENTITY_SERVER_USERNAME'] }
    let(:password) { ENV['IDENTITY_SERVER_PASSWORD'] }
    let(:base) { ENV['IDENTITY_SERVER_URL'] }
    let(:netid) { 'foobar' }
    let(:idcard) { '1234567890' }
    let(:url) { "#{base}?outputformat=json&netid=#{netid}&idcard=#{idcard}" }

    it 'constructs the URL correctly' do
      stub_valid_response
      described_class.get(netid: netid, idcard: idcard)
      expect(HTTParty).to have_received(:get)
        .with(url, basic_auth: { username: username, password: password })
    end
  end

  it 'does not allow queries with invalid params' do
    expect { described_class.get(test: '00001') }
      .to raise_error(RuntimeError)
  end

  it 'raises error when HTTParty returns a non-200 status code' do
    response = file_to_response('./spec/fixtures/api/invalid_request.xml',
                                501)
    allow(HTTParty).to receive(:get) { response }
    expect { described_class.get(netid: 'ls222') }
      .to raise_error(RuntimeError)
  end

  def stub_valid_response
    response = file_to_response('./spec/fixtures/api/success.json', 200)
    allow(HTTParty).to receive(:get).and_return(response)
  end
end
