require 'spec_helper'

describe 'SwipeIntoEvents', type: :feature do
  before :each do
    # @user = create(:user)
    @event = create(:event)
    sign_in(@event.users.first.netid)
  end

# This test is brittle and not providing much value.
  # it 'can navigate to the swipe page' do
  #   visit event_swipe_path(@event)
  #   # brittle but only unique identifier so far.
  #   # We should add a tag with an id to the page?
  #   expect(page).to have_content 'Card Swipe or Card Tap or NetID or Yale Email'
  # end

  context 'using netid' do
    before :each do
      visit event_swipe_path(@event)
      fill_in 'query', with: 'frodo'
      click_on('Submit')
    end
    it 'can swipe someone into the event' do
      expect(page).to have_content 'success'
    end
    it 'someone swiped into the event appears in the attendance list' do
      visit event_path(@event)
      expect(find('#attendance_entries_table')).to have_content 'Frodo'
    end
  end

  xit 'someone swiped into the event is in the attendance list' do
  end
end
