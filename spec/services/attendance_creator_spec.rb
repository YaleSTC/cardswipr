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

  describe 'for event with pregistration' do
    let(:prereg_event) { create(:event, preregistration: true) }
    let(:email) { 'email222@email.com' }

    it 'can create attendance' do
      create(:preregistration, event: prereg_event, net_id: net_id)
      creator2 = described_class.new(event: prereg_event, search_param: net_id)
      stub_people_hub_with(net_id)
      creator2.call
      expect(creator2.attendance.net_id).to eq(net_id)
    end

    it 'sets type to Attendance on corresponding preregistration' do
      prereg = create(:preregistration, event: prereg_event, net_id: net_id)
      creator2 = described_class.new(event: prereg_event, search_param: net_id)
      stub_people_hub_with(net_id)
      creator2.call
      expect(CheckIn.find(prereg.id).type).to eq('Attendance')
    end

    it 'sets checked_in_at on corresponding preregistration' do
      prereg = create(:preregistration, event: prereg_event, net_id: net_id)
      creator2 = described_class.new(event: prereg_event, search_param: net_id)
      stub_people_hub_with(net_id)
      creator2.call
      expect(CheckIn.find(prereg.id).checked_in_at).not_to equal(nil)
    end

    it 'fails to create attendance for non-preregistered person' do
      proxno = '0000000001'
      creator2 = described_class.new(event: prereg_event, search_param: proxno)
      stub_people_hub_with(proxno)
      expect(creator2.call).to eq(false)
    end

    it 'fails to create attendance for person who has already checked in' do
      create(:attendance, event: prereg_event, email: email)
      creator2 = described_class.new(event: prereg_event, search_param: net_id)
      stub_people_hub(email)
      expect(creator2.call).to eq(false)
    end
  end
end
