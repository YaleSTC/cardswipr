# frozen_string_literal: true

require 'rails_helper'
require 'csv'

RSpec.describe 'Preregistration', type: :system do
  let(:user) { create(:user) }
  let(:event) { create(:event_with_preregistrations) }
  let(:net_id) { 'ls222' }

  before do
    create(:user_event, user: user, event: event)
    log_in user
    visit dashboard_path
    click_on('Attendance Info', match: :first)
    click_on('Preregistrations')
  end

  it 'gives a list of all preregistrations' do
    preregistration1 = event.preregistrations.first
    preregistration2 = event.preregistrations.last
    visit current_path
    expect(page).to have_content(preregistration1.first_name.titleize)
      .and have_content(preregistration2.first_name.titleize)
  end

  it 'can be deleted' do
    visit current_path
    click_on('X', match: :first)
    expect(page).to have_content('Successfully deleted preregistration!')
  end

  def log_in(user)
    stub_people_hub
    stub_cas(user.username)
    sign_in user
  end
end
