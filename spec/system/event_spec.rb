# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event', type: :system do
  context 'when signed in as user' do
    let(:event) { create(:event) }

    before do
      stub_and_sign_in(create(:user))
      visit dashboard_path
      click_on('Create New Event')
    end

    it 'user can create an event' do
      fill_in 'event_title', with: 'Unique Party Name 123!'
      fill_in 'event_description', with: 'Bring your friends'
      click_on('Create Event')
      expect(page).to have_content('Successfully created event!')
    end

    it 'user gets failure message when incorrectly creating an event' do
      click_on('Create Event')
      expect(page).to have_content('Unable to create event!')
    end

    it 'focuses text box on page load' do
      visit event_path(event)
      click_on 'Check In Users'
      expect(find_field('prox_number')[:autofocus]).to eq('autofocus')
    end

    it 'checks user into an event' do
      check_in(event)
      visit event_path(event)
      table = page.find(:css, 'table#attendances')
      row_count = table.all(:css, 'tr').size
      expect(row_count).to eq(1)
    end
  end

  def check_in(event)
    stub_check_in
    visit registration_event_path(event)
    fill_in 'prox_number', with: '9999999'
    click_on 'Check In'
  end

  def stub_and_sign_in(user)
    stub_cas(user.username)
    sign_in user
  end

  def stub_check_in
    response = file_to_response("#{RSPEC_ROOT}/fixtures/api/success.json", 200)
    allow(HTTParty).to receive(:get) { response }
    allow(ENV).to receive(:[]).with('IDENTITY_SERVER_URL')
                              .and_return('https://foo.example.com/api/')
  end
end
