# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event', type: :system do
  context 'when signed in as user' do
    before do
      stub_and_sign_in(create(:user))
      visit dashboard_path
      click_on('Create New Event')
    end

    it 'user can create an event' do
      fill_in 'event_title', with: 'Unique Party Name 123!'
      fill_in 'event_description', with: 'Bring your friends'
      click_on('Create Event')
      expect(page).to have_content('Successfully created event!')
    end

    it 'user gets failure message when incorrectly creating an event' do
      click_on('Create Event')
      expect(page).to have_content('Unable to create event!')
    end
  end

  def stub_and_sign_in(user)
    stub_cas(user.username)
    sign_in user
  end
end
