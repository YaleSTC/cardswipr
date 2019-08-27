# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :system do
  let(:user) { create(:user) }

  before { stub_and_sign_in }

  describe 'User Manual page' do
    it 'can be accessed from the home page' do
      visit root_path
      find('#user-manual').click
      expect(page).to have_content('Hardware Recommendations')
    end
  end

  def stub_and_sign_in
    stub_cas(user.username)
    sign_in user
  end
end
