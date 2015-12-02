require 'spec_helper'

describe 'AttendanceManagement', type: :feature do
  before :each do
    @event = create(:event)
    @entry = create(:attendance_entry, event: @event)
    @event.attendance_entries << @entry # adding frodo to event
    sign_in(@event.users.first.netid) # sign in as willy
  end

  it 'should show entry that has been added' do
    visit event_attendance_entries_path(@event)
    expect(page).to have_content('Frodo')
  end

  it 'should not show entries removed from the attendance list' do
    visit event_attendance_entries_path(@event)
    first(:link, 'Delete').click
    page.driver.browser.switch_to.alert.accept # need selenium driver
    expect(page).to_not have_content('Frodo')
  end
end
