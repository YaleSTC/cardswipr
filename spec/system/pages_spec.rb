# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :system do
  before { stub_cas(user.username) }

  context 'when user is not signed in' do
    let(:user) { create(:user) }

    before do
      visit root_path
    end

    context 'when page content' do
      it 'displays sign-in' do
        expect(page.find('div', id: 'page'))
          .to have_selector('a', text: 'Sign In')
      end
    end

    context 'when header content' do
      it 'displays header' do
        expect(page).to have_selector('header')
      end

      it 'does not display username' do
        expect(page).not_to have_selector('header', text: user.username)
      end

      it 'does not display log out' do
        expect(page).not_to have_selector('header', text: 'Log Out')
      end
    end
  end

  context 'when user is signed in' do
    let(:user) { create(:user) }

    before do
      sign_in
    end

    context 'when page content' do
      it 'displays getting started link' do
        expect(page.find('div', id: 'page'))
          .to have_selector('a', text: 'Getting Started')
      end

      it 'displays my events link' do
        expect(page.find('div', id: 'page'))
          .to have_selector('a', text: 'My Events')
      end

      it 'displays person lookup link' do
        expect(page.find('div', id: 'page'))
          .to have_selector('a', text: 'Person Lookup')
      end
    end

    context 'when header content' do
      it 'displays header' do
        expect(page).to have_selector('header')
      end

      it 'displays username in header' do
        expect(page).to have_selector('header', text: user.username)
      end

      it 'displays log out in header' do
        expect(page).to have_selector('header', text: 'Log Out')
      end
    end
  end

  def sign_in
    visit root_path
    click_on 'Sign In'
  end
end
