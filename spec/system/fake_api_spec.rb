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
      create_event
      visit root_path
      click_on "Event Check-in"
      fill_in :prox_number, with: "0000000000"
      click_on "Check In"
      expect(page).to have_content('Successfully checked in!')
    end

    def create_event
      visit new_event_path
      fill_in :title, with: "foo"
      fill_in :description, with: "bar"
      click_on "Submit"
    end
  end
end
