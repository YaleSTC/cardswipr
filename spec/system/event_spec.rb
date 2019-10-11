# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event', type: :system do
  context 'when signed in as user' do
    before do
      stub_and_sign_in(create(:user))
      visit dashboard_path
      find('#new_event_link', visible: false).click
    end

    it 'user can create an event' do
      fill_in 'event_title', with: 'Unique Party Name 123!'
      fill_in 'event_description', with: 'Bring your friends'
      click_on('Create Event')
      expect(page).to have_content('Successfully created event!')
    end

    it 'user gets failure message when event title is blank' do
      click_on('Create Event')
      expect(page).to have_content('Title can\'t be blank')
    end

    it 'user gets failure message when event title is too long' do
      fill_in 'event_title', with: 'a' * 51
      click_on('Create Event')
      expect(page).to have_content('Title is too long')
    end
  end

  it 'cannot be accessed by user without user_event' do
    stub_and_sign_in(create(:user))
    user2 = create(:user_with_events)
    event = user2.events.last
    visit event_path(event)
    expect(page).to have_content("Sorry, you don't have permission to do that")
  end

  def stub_and_sign_in(user)
    stub_cas(user.username)
    sign_in user
  end
end
