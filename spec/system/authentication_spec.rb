# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before { stub_cas('NETID') }

  it 'redirects user to dashboard after sign in' do
    visit root_path
    click_on 'sign in'
    expect(page).to have_content('Dashboard')
  end

  context 'when user is authenticated' do
    it 'does not display the sign in link' do
      visit root_path
      click_on 'sign in'
      expect(page).not_to have_content('sign in')
    end
  end

  context 'when user is unauthenticated' do
    it 'does displays the sign in link' do
      visit root_path
      expect(page).to have_content('sign in')
    end
  end
end
