# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PreregistrationCreator do
  let(:event) { create(:event, preregistration: true) }
  let(:net_id) { 'ls222' }
  let(:creator) do
    described_class.new(event: event, search_param: net_id)
  end

  it 'creates preregistration for correct event' do
    stub_people_hub_with(net_id)
    creator.call
    expect(creator.preregistration.event).to eq(event)
  end

  it 'creates preregistration for correct person' do
    stub_people_hub_with(net_id)
    creator.call
    expect(creator.preregistration.net_id).to eq(net_id)
  end

  it 'fails to create preregistration for person who has already checked in' do
    email = 'checkedin@email.com'
    create(:attendance, event: event, email: email)
    stub_people_hub(email)
    expect(creator.call).to eq(false)
  end
end
