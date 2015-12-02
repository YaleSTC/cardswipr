require 'spec_helper'

describe 'SwipeIntoEvents', type: :feature do
  before :each do
    @event = create(:event)
    sign_in(@event.users.first.netid)
  end

  context 'using netid' do
    before :each do
      visit event_swipe_path(@event)
      fill_in 'query', with: 'frodo'
      sleep 1
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

  context 'using prox number' do
    before :each do
      visit event_swipe_path(@event)
      fill_in 'query', with: '0000000002'
      sleep 1
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

end
