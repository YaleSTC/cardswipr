# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attendance', type: :system do
  before { stub_cas(user_with_events.username) }

  context 'when signed in as user' do
    let(:user_with_events) { create(:user_with_events) }

    it 'gives a list of all attendees' do
      attendee1, attendee2 = config
      click_on('Attendee List', match: :first)
      expect(page).to have_content(attendee1.first_name.titleize)
        .and have_content(attendee2.first_name.titleize)
    end
  end

  def config
    attendee1, attendee2 = create_pair(:attendance,
                                       event: user_with_events.events.first)
    visit dashboard_path
    page.find(:id, 'page').click_link 'My Events'
    [attendee1, attendee2]
  end
end
