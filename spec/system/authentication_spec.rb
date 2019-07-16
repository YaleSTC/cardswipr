# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  let(:user_with_events) { create(:user_with_events) }

  before { stub_cas('NETID') }

  describe 'after user is authenticated' do
    before do
      visit root_path
      click_on 'Log in'
    end

    it 'redirects user to public home page after sign in' do
      s = ['Welcome to CardSwipr', 'My Events', 'Person Lookup', 'User Manual']
      s.each do |c|
        expect(page).to have_content(c)
      end
    end

    it 'does not display the sign in link' do
      expect(page).not_to have_button('Log in')
    end
  end

  describe 'before user is unauthenticated' do
    it 'does displays the Log in link' do
      visit root_path
      expect(page).to have_button('Log in')
    end

    it 'redirects to the home page, upon visiting an event page' do
      id = user_with_events.events[0].id
      visit event_path(id)
      check_content
    end
  end

  def check_content
    content = ['Welcome to CardSwipr', 'Please sign in']
    content.each do |s|
      expect(page).to have_content(s)
    end
  end
end
