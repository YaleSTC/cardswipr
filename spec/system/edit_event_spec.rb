# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event editing', type: :system do
  it 'displays updated title on dashboard' do
    set_up
    fill_in 'event_title', with: 'Updated Title'
    click_on 'Update Event'
    find('#my_events_link', visible: false).click
    expect(page).to have_content('Updated Title')
  end

  it 'successfully updates event description' do
    _user, event = set_up
    fill_in 'event_description', with: 'Updated Description'
    click_on 'Update Event'
    expect(event.reload.description).to eq('Updated Description')
  end

  it 'displays message after success' do
    set_up
    fill_in 'event_title', with: 'Updated Title'
    click_on 'Update Event'
    expect(page).to have_content('Event Updated')
  end

  describe 'event organizers' do
    it 'can be added' do
      _user, event, other_user = set_up
      add_organizer(other_user.username)
      expect(event.reload.user_events.length).to eq(3)
    end

    it 'message displayed after adding' do
      _user, _event, other_user = set_up
      notice = "#{other_user.full_name} added to event organizers"
      add_organizer(other_user.username)
      expect(page).to have_content(notice)
    end

    it 'message displayed after failure to add' do
      set_up
      stub_failed_people_hub('ni123')
      add_organizer('ni123')
      expect(page).to have_content('User not found')
    end

    it 'cannot be added multiple times' do
      _user, _event, other_user = set_up
      add_organizer(other_user.username)
      add_organizer(other_user.username)
      expect(page)
        .to have_content('User is already an organizer on this event')
    end

    it 'can be removed' do
      user, event = set_up
      remove_organizer(user)
      expect(event.reload.user_events.length).to eq(1)
    end

    it 'message displayed after removing' do
      _user, _event, _other_user, organizer = set_up
      notice = "#{organizer.full_name} removed from event organizers"
      remove_organizer(organizer)
      expect(page).to have_content(notice)
    end

    it 'cannot be removed if there is only one organizer' do
      user1 = create(:user)
      event = create(:event, users: [user1])
      log_in user1
      remove_organizer(user1)
      expect(event.reload.user_events.length).to eq(1)
    end

    it 'are displayed in alphabetical order by last name' do
      user1 = create(:user, first_name: 'zf', last_name: 'al', username: ' ')
      user2 = create(:user, first_name: 'Afirst', last_name: 'Blast')
      create(:event, users: [user2, user1])
      log_in user1
      # The regex will check that person zf al is before person Afirst Blast
      expect(page.text).to match(/zf al.*Afirst Blast/)
    end
  end

  def set_up
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    event = create(:event, users: [user1, user2])
    log_in user1
    [user1, event, user3, user2]
  end

  def log_in(user)
    stub_cas(user.username)
    sign_in user
    visit dashboard_path
    click_on 'Edit Event'
  end

  def add_organizer(username)
    fill_in 'organizer', with: username
    click_on 'Add Organizer'
  end

  def remove_organizer(user)
    find('tr', id: 'remove-' + user.username).click_on('X')
  end
end
