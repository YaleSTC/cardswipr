# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Preregistration', type: :system do
  let(:user) { create(:user) }
  let(:event) { create(:event_with_preregistrations) }

  before do
    create(:user_event, user: user, event: event)
    stub_people_hub
    stub_cas(user.username)
    sign_in user
    visit dashboard_path
    click_on('Attendance Info', match: :first)
    click_on('Preregistrations', match: :first)
  end

  context 'when signed in as user' do
    it 'gives a list of all preregistrations' do
      preregistration1 = event.preregistrations.first
      preregistration2 = event.preregistrations.last
      visit current_path
      expect(page).to have_content(preregistration1.first_name.titleize)
        .and have_content(preregistration2.first_name.titleize)
    end

    it 'highlights row if preregistered user checked in' do
      preregistration1 = event.preregistrations.first
      preregistration1.update(checked_in: true)
      visit current_path
      expect(page).to have_css('tr.alert-primary', count: 1)
    end
  end
end
