# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Attendance with preregistration', type: :system do
  let(:user) { create(:user) }
  let(:event) { create(:event, preregistration: true) }

  before do
    stub_people_hub
    stub_cas(user.username)
    sign_in user
    create(:user_event, user: user, event: event)
  end

  it 'displays success message for registered attendee' do
    create(:preregistration, event: event, net_id: 'ls222')
    check_in('ls2222')
    expect(page).to have_content('Successfully checked in')
  end

  it 'displays failure message for unregistered attendee' do
    check_in('000000000')
    expect(page).to have_content('This person has not preregistered')
  end

  def check_in(search_param)
    visit dashboard_path
    click_on 'Event Check-in', match: :first
    fill_in 'search_param', with: search_param
    click_on 'Check In'
  end
end
