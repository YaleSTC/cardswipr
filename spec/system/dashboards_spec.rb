# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards', type: :system do
  context 'when signed in as user' do
    let(:user_with_events) { create(:user_with_events, event_count: 2) }

    before do
      stub_cas(user_with_events.username)
      sign_in user_with_events
    end

    it "lists only the user's events" do
      visit dashboard_path
      create(:event)
      row_count = get_event_rows(page).size
      expect(row_count).to eq(2)
    end

    it 'deletes event on click' do
      visit dashboard_path
      get_event_rows(page).first.click_on('X')
      row_count = get_event_rows(page).size
      expect(row_count).to eq(1)
    end
  end

  describe 'pagination' do
    let(:user_with_events) { create(:user_with_events, event_count: 6) }

    before do
      stub_cas(user_with_events.username)
      sign_in user_with_events
    end

    it 'only contains 5 events per page' do
      visit dashboard_path
      oldest_event = user_with_events.events.first
      expect(page).not_to have_content(oldest_event.title)
    end

    it 'puts the sixth event on the second page' do
      visit dashboard_path
      click_on('Next')
      oldest_event = user_with_events.events.first
      expect(page).to have_content(oldest_event.title)
    end
  end
end
