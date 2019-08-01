# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User', type: :system do
  let(:username) { 'ls222' }
  let(:email) { 'luke.skywalker@mail.com' }

  before do
    stub_cas(username)
    stub_people_hub(email)
  end

  it 'has correct email address' do
    visit root_path
    click_on 'Log in'
    user = User.find_by(username: 'ls222')
    expect(user.email).to eq(email)
  end

  context 'when signed in' do
    let(:user) { create(:user) }

    before { sign_in user }

    it 'can be updated' do
      visit edit_user_path(user.id)
      fill_in 'First Name', with: 'NewFirstName'
      click_on 'Update User'
      expect(user.reload.first_name).to eq('NewFirstName')
    end

    it 'displays success message when update succeeds' do
      visit edit_user_path(user.id)
      fill_in 'Email', with: 'email@email.com'
      click_on 'Update User'
      expect(page).to have_content('User updated successfully!')
    end

    it 'displays error message when update fails' do
      visit edit_user_path(user.id)
      fill_in 'Last Name', with: ''
      click_on 'Update User'
      expect(page).to have_content('Last name can\'t be blank')
    end
  end
end
