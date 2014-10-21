require 'spec_helper'

describe 'SwipeIntoEvents', type: :feature do
  before :each do
    # @user = create(:user)
    @event = create(:event)
    sign_in(@event.users.first.netid)
  end

  it 'can navigate to the swipe page' do
    visit event_swipe_path(@event)
    # brittle but only unique identifier so far.
    # We should add a tag with an id to the page?
    expect(page).to have_content 'Card Swipe or Card Tap or NetID or Yale Email'
  end

  context 'using netid' do
    it 'can swipe someone into the event' do
      visit event_swipe_path(@event)
      fill_in 'query', with: 'csw3'
      click_on('Submit')
      expect(page).to have_content 'success'
    end
  end

  context 'using prox card number' do
    it 'can swipe someone into the event' do
      visit event_swipe_path(@event)
      fill_in 'query', with: 'casey.watts@yale.edu'
      click_on('Submit')
      expect(page).to have_content 'success'
    end
  end

  context 'using prox card number' do
    it 'can swipe someone into the event' do
      visit event_swipe_path(@event)
      fill_in 'query', with: '0099012345'
      click_on('Submit')
      expect(page).to have_content 'success'
    end
  end

  context 'using magstripe number' do
    it 'can swipe someone into the event' do
      visit event_swipe_path(@event)
      fill_in 'query', with: '9900012345'
      click_on('Submit')
      expect(page).to have_content 'success'
    end
  end


  xit 'someone swiped into the event is in the attendance list' do
  end
end
