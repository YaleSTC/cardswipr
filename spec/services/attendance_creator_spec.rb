# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendanceCreator do
  let(:event) { create(:event) }
  let(:net_id) { 'ls222' }
  let(:creator) do
    described_class.new(event: event, search_param: net_id)
  end

  it 'creates attendance for correct event' do
    stub_people_hub_with(net_id)
    creator.call
    expect(creator.attendance.event).to eq(event)
  end

  it 'creates attendance for correct person' do
    stub_people_hub_with(net_id)
    creator.call
    expect(creator.attendance.first_name).to eq('Luke')
  end

  it 'can create attendance for an event using proxnumber' do
    stub_people_hub_with('0000000000')
    prox_creator = described_class.new(event: event,
                                       search_param: '0000000000')
    prox_creator.call
    expect(prox_creator.attendance.net_id).to eq('ls222')
  end

  it 'updates updated_at for the event' do
    stub_people_hub_with(net_id)
    expect { creator.call }.to change(event, :updated_at)
  end
end
