# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Basic Heartbeat Test', type: :system do
  it 'has an h1 tag' do
    visit root_path
    expect(page).to have_content('Welcome to Cardswipr')
  end
end
