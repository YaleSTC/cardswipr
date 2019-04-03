# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PersonLookups', type: :system do
  context 'when signed in as user' do
    let(:user) { create(:user) }

    before do
      stub_cas(user.username)
      sign_in user
    end

    it 'successfully looks up a user based on card swipe/tap' do
      mock_successful_api_call
      visit new_person_lookup_path
      fill_in 'arguments', with: '999999999'
      click_on 'Submit'
      expect(page).to have_css('div#result')
    end
  end
end
