# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleHub::ParamsParser do
  describe '#create_search_hash' do
    it 'correctly returns a search_hash' do
      search_param = '0000000000'
      expect(described_class.create_search_hash(search_param))
        .to eq(proxnumber: search_param)
    end
    it 'correctly handles more than one search param' do
      netid = 'abc222'
      proxnum = '0000000000'
      result = { netid: netid, proxnumber: proxnum }
      expect(described_class.create_search_hash(netid, proxnum))
        .to eq(result)
    end
  end

  describe '#determine_key' do
    it 'returns :proxnumber if given a proxnumber' do
      search_param = '0000000000'
      expect(described_class
             .determine_key(search_param)).to eq(:proxnumber)
    end
    it 'returns :netid if given a net id' do
      search_param = 'abc222'
      expect(described_class
             .determine_key(search_param)).to eq(:netid)
    end
    it 'returns :netid if given a vanity net id' do
      search_param = 'testid'
      expect(described_class
             .determine_key(search_param)).to eq(:netid)
    end
    it 'returns :invalid_param if given number with length > 10' do
      search_param = '01234567899'
      expect(described_class
             .determine_key(search_param)).to eq(:invalid_param)
    end
  end
end
