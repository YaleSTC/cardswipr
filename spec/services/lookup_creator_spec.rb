# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LookupCreator do
  let(:net_id) { 'ls222' }
  let(:creator) do
    described_class.new(search_param: net_id)
  end

  it 'finds the correct person' do
    stub_people_hub_with(net_id)
    creator.call
    expect(creator.lookup.first_name).to eq('Luke')
  end
end
