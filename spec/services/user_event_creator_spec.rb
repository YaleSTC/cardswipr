# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserEventCreator do
  let(:event) { create(:event) }
  let(:event_id) { event.id }
  let(:net_id) { 'ls222' }
  let(:creator) do
    described_class.new(search_param: { event_id: event_id, organizer: net_id })
  end

  before do
    stub_people_hub(netid: net_id)
    creator.call
  end

  it 'creates user_event with correct event' do
    expect(creator.user_event.event).to eq(event)
  end

  it 'creates user_event with correct person' do
    expect(creator.user.first_name).to eq('Luke')
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
