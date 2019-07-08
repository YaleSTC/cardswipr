# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'application/_nav.html.erb', type: :view do
  context 'when user is logged in' do
    it 'has a link to the user\'s profile' do
      skip
    end
    it 'has a link to log out' do
      allow(view).to receive(:user_signed_in?).and_return(true)
      render
      expect(response).to have_content('Log Out')
    end
  end

  context 'when user is not logged in' do
    it 'has a link to log in' do
      allow(view).to receive(:user_signed_in?).and_return(false)
      render
      expect(response).to have_link('Log In')
    end
  end
end
