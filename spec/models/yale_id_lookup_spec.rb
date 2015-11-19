require 'spec_helper'

RSpec.describe YaleIDLookup, type: :model do

  context 'using netid' do
    it "can determine someone's identity" do
      lookup_result = YaleIDLookup.lookup('willy')
      expect(lookup_result.first_name).to eq 'Willy'
    end
  end

  context 'using email' do
    it "can determine someone's identity" do
      lookup_result = YaleIDLookup.lookup('willy@example.com')
      expect(lookup_result.first_name).to eq 'Willy'
    end
  end

  context 'using prox card number' do
    it "can determine someone's identity" do
      # a dummy prox card number that will return a UPI but isn't an active card
      lookup_result = YaleIDLookup.lookup('0000000001')
      expect(lookup_result.first_name).to eq 'Willy'
    end
  end

  context 'using magstripe number' do
    it "can determine someone's identity" do
      # a dummy magstripe number that will return a UPI but isn't an active card
      lookup_result = YaleIDLookup.lookup('1000000001')
      expect(lookup_result.first_name).to eq 'Willy'
    end
  end

end
