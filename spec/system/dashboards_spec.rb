# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Dashboards', type: :system do
  context 'when signed in as user' do
    let(:user_with_events) { create(:user_with_events) }

    before do
      stub_cas(user_with_events.username)
      sign_in user_with_events
    end

    it 'lists user events' do
      visit dashboard_path
      row_count = get_event_rows(page).size
      expect(row_count).to eq(5)
    end

    it 'deletes event on click' do
      visit dashboard_path
      rows = get_event_rows(page)
      rows.first.click_on('Delete Event')
      row_count = get_event_rows(page).size
      expect(row_count).to eq(4)
    end
  end
end
