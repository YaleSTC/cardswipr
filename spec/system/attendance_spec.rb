# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attendance', type: :system do
  context 'when signed in as user' do
    let(:user_with_events) { create(:user_with_events) }

    before { stub_cas(user_with_events.username) }

    it 'can view a list of all attendees' do
      attendee1, attendee2 = setup_attendances
      expect(page).to have_content(attendee1.first_name.titleize)
        .and have_content(attendee2.first_name.titleize)
    end

    it 'displays message for successful check-in' do
      stub_check_in
      check_in('0000000000')
      expect(page).to have_content('Successfully checked in Luke Skywalker!')
    end

    it 'displays message for failed check-in' do
      invalid_param = '1'
      stub_failed_check_in(invalid_param)
      check_in(invalid_param)
      expect(page).to have_content('Check-in failed')
    end

    it 'focuses text box on page load' do
      visit dashboard_path
      click_on 'Event Check-in', match: :first
      expect(find_field('search_param')[:autofocus]).to eq('autofocus')
    end

    it 'has a button to export attendances to CSV' do
      setup_attendances
      expect(page).to have_button('Export CSV')
    end

    it 'downloads the csv' do
      setup_attendances
      click_on('Export CSV')
      rheader = page.response_headers['Content-Disposition']
      expect(rheader).to match('attachment')
    end

    # Note: this test may fail if run at midnight because of the day change
    it 'downloads the csv with correct filename' do
      setup_attendances
      click_on('Export CSV')
      fname = user_with_events.events.first.title
      fname << ('_export_' + Time.zone.today.to_s(:number) + '.csv')
      expect(page.response_headers['Content-Disposition']).to match(fname)
    end

    it 'has the right content' do
      data = setup_attendances
      click_on('Export CSV')
      export = 'first_name,last_name,email,net_id,upi,check_in'
      export += data.map { |n| export_row_for(n) }.join
      expect(page.html).to have_content(export)
    end
  end

  def setup_attendances
    attendee1, attendee2 = create_pair(:attendance,
                                       event: user_with_events.events.first)
    visit dashboard_path
    click_on('Attendee List', match: :first)
    [attendee1, attendee2]
  end

  def check_in(search_param)
    visit dashboard_path
    click_on 'Event Check-in', match: :first
    fill_in 'search_param', with: search_param
    click_on 'Check In'
  end

  def stub_check_in
    person = instance_double(PeopleHub::Person, person_attrs)
    allow(PeopleHub::PersonRequest).to receive(:get).and_return(person)
  end

  def person_attrs
    { first_name: 'Luke', last_name: 'Skywalker',
      email: 'luke.skywalker@mail.com', net_id: 'ls222', upi: '12345678',
      phone: '+1 (555) 555-5555' }
  end

  def stub_failed_check_in(search_param)
    allow(PeopleHub::PersonRequest).to \
      receive(:get).with(invalid_param: search_param).and_raise(RuntimeError)
  end

  def export_row_for(attendance)
    "\n" + [attendance.first_name, attendance.last_name, attendance.email,
            attendance.net_id, attendance.upi, attendance.check_in].join(',')
  end
end
