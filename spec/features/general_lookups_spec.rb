require 'spec_helper'

describe 'GeneralLookups', type: :feature do
  before :each do
    @user = create(:user, netid: 'willy', first_name: 'Willy', last_name: 'Wonka')
    sign_in(@user.netid)
  end

  it 'can navigate to the general lookups page' do
    visit distribution_personlookup_path
    # brittle but only unique identifier so far
    expect(page).to have_content 'Card Swipe or Card Tap or NetID or Yale Email'
  end

  it 'can look someone up by netid' do
    visit distribution_personlookup_path

    fill_in 'query', with: 'frodo'
    click_on('Submit')
    expect(page).to have_content 'Baggins'
  end
end
