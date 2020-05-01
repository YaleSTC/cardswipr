# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attendance', type: :system do
  let(:user_with_events) { create(:user_with_events) }
  let(:event) { user_with_events.events.last }

  before do
    stub_people_hub
    stub_cas(user_with_events.username)
    sign_in user_with_events
    visit dashboard_path
    click_on('Attendance Info', match: :first)
  end

  context 'when signed in as user' do
    it 'gives a list of all attendees' do
      attendee1, attendee2 = generate_attendances
      visit current_path
      expect(page).to have_content(attendee1.first_name.titleize)
        .and have_content(attendee2.first_name.titleize)
    end

    it 'displays message for successful check-in' do
      check_in('0000000000')
      expect(page).to have_content('Successfully checked in Luke Skywalker!')
    end

    it 'displays message for failed check-in' do
      invalid_param = '1'
      stub_failed_people_hub(invalid_param)
      check_in(invalid_param)
      expect(page).to have_content('Check-in failed')
    end

    it 'focuses text box on page load' do
      visit dashboard_path
      click_on 'Event Check-in', match: :first
      expect(find_field('search_param')[:autofocus]).to eq('autofocus')
    end

    it 'has a button to export attendances to CSV' do
      expect(page).to have_button('Export CSV')
    end

    it 'downloads the csv' do
      generate_attendances
      click_on('Export CSV')
      rheader = page.response_headers['Content-Disposition']
      expect(rheader).to match('attachment')
    end

    # Note: this test may fail if run at midnight because of the day change
    it 'downloads the csv with correct filename' do
      generate_attendances
      click_on('Export CSV')
      fname = event.title
      fname << ('_export_' + Time.zone.today.to_s(:number) + '.csv')
      expect(page.response_headers['Content-Disposition']).to match(fname)
    end

    it 'has the right content' do
      data = generate_attendances
      click_on('Export CSV')
      export = 'first_name,last_name,email,net_id,upi,checked_in_at'
      export += data.map { |n| export_row_for(n) }.join
      expect(page.html).to have_content(export)
    end

    it 'can be deleted' do
      generate_attendances
      visit current_path
      click_on('X', match: :first)
      expect(page).to have_content('Successfully deleted attendance!')
    end
  end

  def generate_attendances
    create_pair(:attendance, event: event)
  end

  def check_in(search_param)
    visit dashboard_path
    click_on 'Event Check-in', match: :first
    fill_in 'search_param', with: search_param
    click_on 'Check In'
  end

  def export_row_for(attendance)
    "\n" + [attendance.first_name, attendance.last_name, attendance.email,
            attendance.net_id, attendance.upi, attendance.checked_in_at]
           .join(',')
  end
end
