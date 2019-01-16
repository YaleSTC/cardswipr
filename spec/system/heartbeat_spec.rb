require 'rails_helper'

RSpec.describe 'Basic Heartbeat Test' do
  it 'has an h1 tag' do
    visit root_path
    expect(page).to have_selector('h1')
  end
end
