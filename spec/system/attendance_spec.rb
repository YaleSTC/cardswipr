# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attendance', type: :system do
  before do
    stub_cas(user_with_events.username)
    visit dashboard_path
    click_on('Attendee List', match: :first)
  end

  context 'when signed in as user' do
    let(:user_with_events) { create(:user_with_events) }

    it 'gives a list of all attendees' do
      attendee1, attendee2 = setup
      visit dashboard_path
      click_on('Attendee List', match: :first)
      expect(page).to have_content(attendee1.first_name.titleize)
        .and have_content(attendee2.first_name.titleize)
    end

    it 'has a button to export attendances to CSV' do
      setup
      expect(page).to have_link('Export CSV')
    end

    it 'downloads the csv' do
      setup
      click_on('Export CSV')
      rheader = page.response_headers['Content-Disposition']
      expect(rheader).to match('attachment')
    end

    # Note: this test may fail if run at midnight because of the day change
    it 'downloads the csv with correct filename' do
      setup
      click_on('Export CSV')
      fname = user_with_events.events.first.title
      fname << ('_export_' + Time.zone.today.to_s(:number) + '.csv')
      expect(page.response_headers['Content-Disposition']).to match(fname)
    end

    it 'has the right content' do
      data = setup
      click_on('Export CSV')
      export = 'first_name,email' + data.map { |n| export_row_for(n) }.join
      expect(page.html).to have_content(export)
    end
  end

  def export_row_for(attendance)
    "\n" + [attendance.first_name, attendance.email].join(',')
  end

  def setup
    create_pair(:attendance, event: user_with_events.events.first)
    ' ' + [attendance.first_name, attendance.email].join(',')
  end

  def setup
    attendee1, attendee2 = create_pair(:attendance,
                                       event: user_with_events.events.first)
    [attendee1, attendee2]
  end
end
