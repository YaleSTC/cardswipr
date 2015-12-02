require 'spec_helper'

describe 'EventManagement', type: :feature do
  before :each do
    @event = create(:event)
    @user = @event.users.first
    sign_in(@user.netid)
  end

  it 'can create a new event' do
    visit new_event_path
    fill_out_event
    click_on('Create Event')
    expect(page).to have_content 'success'
  end
  it 'can edit an existing event' do
    visit edit_event_path(@event)
    fill_out_event_alternative_content
    click_on('Update Event')
    expect(page).to have_content 'success'
  end
  it 'can view the attendance list for an event' do
    visit event_path(@event)
    expect(page).to have_content 'Attendance List'
  end
end

def fill_out_event
  fill_in 'event_title', with: 'Serious Session'
  fill_in 'event_description', with: 'Please swipe your card just once or else.'
  select 'Willy Wonka willy', from: 'event[user_ids][]'
end

def fill_out_event_alternative_content
  fill_in 'event_title', with: 'Silly Session'
  fill_in 'event_description', with: 'Lalalala'
  select 'Willy Wonka willy', from: 'event[user_ids][]'
end
