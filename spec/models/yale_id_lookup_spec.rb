require 'spec_helper'

RSpec.describe YaleIDLookup, type: :model do

  context 'using netid' do
    it "can determine someone's identity" do
      lookup_result = YaleIDLookup.lookup('csw3')
      expect(lookup_result[:first_name]).to eq 'Casey'
    end
  end

  context 'using email' do
    it "can determine someone's identity" do
      lookup_result = YaleIDLookup.lookup('casey.watts@yale.edu')
      expect(lookup_result[:first_name]).to eq 'Casey'
    end
  end

  context 'using prox card number' do
    it "can determine someone's identity" do
      # a dummy prox card number that will return a UPI but isn't an active card
      lookup_result = YaleIDLookup.lookup('0099012345')
      expect(lookup_result[:first_name]).to eq 'Casey'
    end
  end

  context 'using magstripe number' do
    it "can determine someone's identity" do
      # a dummy magstripe number that will return a UPI but isn't an active card
      lookup_result = YaleIDLookup.lookup('9900012345')
      expect(lookup_result[:first_name]).to eq 'Casey'
    end
  end

end
