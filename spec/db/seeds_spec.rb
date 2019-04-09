# frozen_string_literal: true

require 'rails_helper'
# rubocop:disable DescribeClass
RSpec.describe 'db seed' do
  # rubocop:enable DescribeClass
  before do
    allow($stdout).to receive(:puts)
    allow($stdin).to receive(:gets).and_return('zzz99\n')
  end

  it 'asks for your NetID' do
    Rails.application.load_seed
    expect($stdout).to have_received(:puts).with('Please enter your NetID').once
  end

  it 'takes in your input' do
    Rails.application.load_seed
    expect($stdin).to have_received(:gets).once
  end

  it 'creates a user' do
    expect { Rails.application.load_seed }.to change(User, :count)
  end

  it 'creates an event' do
    expect { Rails.application.load_seed }.to change(Event, :count)
  end

  it 'creates an attendance' do
    expect { Rails.application.load_seed }.to change(Attendance, :count)
  end
end
