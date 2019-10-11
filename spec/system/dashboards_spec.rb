# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards', type: :system do
  context 'when signed in as user' do
    let(:user_with_events) { create(:user_with_events, event_count: 5) }

    before do
      stub_cas(user_with_events.username)
      sign_in user_with_events
    end

    it "lists only the user's events" do
      visit dashboard_path
      create(:event)
      row_count = get_event_rows(page).size
      expect(row_count).to eq(5)
    end

    it 'deletes event on click' do
      visit dashboard_path
      get_event_rows(page).first.click_on('X')
      row_count = get_event_rows(page).size
      expect(row_count).to eq(4)
    end
  end
end
