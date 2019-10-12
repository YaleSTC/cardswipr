# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Heartbeat', type: :request do
  it 'returns ok when the app is live' do
    get heartbeat_path
    expect(response.body).to include('Application is up.')
  end
end
