# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Flashes', type: :system do
  # tests application_controller#flash_alerts
  describe 'alert' do
    it 'when there is an error' do
      error = create_error
      expect(page).to have_css('div.alert-warning', text: error)
    end

    it 'that disappears upon leaving page' do
      error = create_error
      find('#my_events_link', visible: false).click
      expect(page).not_to have_content(error)
    end
  end

  def create_error
    user1 = create(:user)
    create(:event, users: [user1])
    log_in(user1)
    click_on 'Edit Event'
    fill_in 'event_title', with: ' '
    click_on 'Update Event'
    'Title can\'t be blank'
  end

  def log_in(user)
    stub_people_hub
    stub_cas(user.username)
    sign_in user
    visit dashboard_path
  end
end
