# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AttendanceCreator do
  let(:event) { create(:event) }
  let(:net_id) { 'ls222' }
  let(:creator) do
    described_class.new(event: event, search_param: net_id)
  end

  it 'creates attendance for correct event' do
    stub_people_hub(netid: net_id)
    creator.call
    expect(creator.attendance.event).to eq(event)
  end

  it 'creates attendance for correct person' do
    stub_people_hub(netid: net_id)
    creator.call
    expect(creator.attendance.first_name).to eq('Luke')
  end

  it 'can create attendance for an event using proxnumber' do
    stub_people_hub(proxnumber: '0000000000')
    prox_creator = described_class.new(event: event,
                                       search_param: '0000000000')
    prox_creator.call
    expect(prox_creator.attendance.net_id).to eq('ls222')
  end

  describe '#determine_key' do
    it 'returns :proxnumber if given a proxnumber' do
      expect(creator.determine_key('0000000000')).to eq(:proxnumber)
    end
    it 'returns :netid if given a net id' do
      expect(creator.determine_key('abc222')).to eq(:netid)
    end
    it 'returns :invalid_param if given param that is not alphanumeric' do
      expect(creator.determine_key('*ls222')).to eq(:invalid_param)
    end
    it 'returns :invalid_param if given number with length > 10' do
      expect(creator.determine_key('01234567899')).to eq(:invalid_param)
    end
  end

  def stub_people_hub(search_hash)
    person = instance_double(PeopleHub::Person, person_attrs)
    allow(PeopleHub::PersonRequest).to \
      receive(:get).with(search_hash).and_return(person)
  end

  def person_attrs
    { first_name: 'Luke', last_name: 'Skywalker',
      email: 'luke.skywalker@mail.com', net_id: 'ls222', upi: '12345678',
      phone: '+1 (555) 555-5555' }
  end
end
