# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Flashes', type: :system do
  # tests application_controller#flash_alert
  describe 'alert' do
    it 'when there is an error' do
      error = create_error
      expect(page).to have_css('p.alert', text: error) 
    end

    it 'that disappears upon leaving page' do
      error = create_error
      click_on 'Back to Dashboard'
      expect(page).not_to have_content(error)
    end
  end

  def create_error
    user1 = create(:user)
    create(:event, users: [user1])
    log_in(user1)
    click_on 'Edit Event'
    fill_in 'Title', with: ' '
    click_on 'Update Event'
    'Title can\'t be blank'
  end

  def log_in(user)
    stub_cas(user.username)
    visit dashboard_path
  end
end
