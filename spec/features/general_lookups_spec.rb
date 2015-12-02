require 'spec_helper'

describe 'GeneralLookups', type: :feature do
  before :each do
    @user = create(:user) # creating willy
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
    sleep 1 # somehow the following click_on does not pick up the query input if I don't sleep here.
    click_on('Submit')
    expect(page).to have_content 'Baggins'
  end
end
