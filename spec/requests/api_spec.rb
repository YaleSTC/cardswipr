# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'API', type: :request do
  context 'when the API query succeeds' do
    before { stub_people_hub }

    it 'displays success message' do
      message = { response: 'API is up', status: :ok }.to_s
      get heartbeat_api_path
      expect(response.body).to include(message)
    end
  end

  context 'when the API query fails' do
    before { stub_failed_people_hub(netid: 'sl2393') }

    it 'displays failure message' do
      message = { response: 'API is down', status: :service_unavailable }.to_s
      get heartbeat_api_path
      expect(response.body).to include(message)
    end
  end
end
