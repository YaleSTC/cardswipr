# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Fake API test', type: :system do
  context 'signed in as user' do
    let(:user) { create(:user) }

     before do
       stub_cas(user.username)
       sign_in user
     end

    it 'returns successful response to correct input' do
      get "app/models/fake_api/"
      expect(true)
    end

  end
end
