# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Event editing', type: :system do
  it 'displays updated title on dashboard' do
    set_up
    fill_in 'Title', with: 'Updated Title'
    click_on 'Update Event'
    click_on 'Back to Dashboard'
    expect(page).to have_content('Updated Title')
  end

  it 'successfully updates event description' do
    _user, _other_user, event = set_up
    fill_in 'Description', with: 'Updated Description'
    click_on 'Update Event'
    expect(event.reload.description).to eq('Updated Description')
  end

  it 'displays message after success' do
    set_up
    fill_in 'Title', with: 'Updated Title'
    click_on 'Update Event'
    expect(page).to have_content('Event Updated')
  end

  describe 'event organizers' do
    it 'can be added' do
      _user, other_user, event = set_up
      add_organizer(other_user)
      expect(event.reload.user_events.length).to eq(3)
    end

    it 'message displayed after adding' do
      _user, other_user, _event = set_up
      notice = "#{other_user.username} added to event organizers"
      add_organizer(other_user)
      expect(page).to have_content(notice)
    end

    it 'cannot be added multiple times' do
      _user, other_user, event = set_up
      add_organizer(other_user)
      add_organizer(other_user)
      expect(event.reload.user_events.length).to eq(3)
    end

    it 'can be removed' do
      user, _other_user, event = set_up
      remove_organizer(user)
      expect(event.reload.user_events.length).to eq(1)
    end

    it 'message displayed after removing' do
      user, _other_user, _event = set_up
      notice = "#{user.username} removed from event organizers"
      remove_organizer(user)
      expect(page).to have_content(notice)
    end

    it 'cannot be removed if there is only one organizer' do
      user1 = create(:user)
      event = create(:event, users: [user1])
      log_in user1
      remove_organizer(user1)
      expect(event.reload.user_events.length).to eq(1)
    end

    it 'are displayed in alphabetical order by username' do
      user1 = create(:user, username: 'a')
      user2 = create(:user, username: 'B')
      create(:event, users: [user2, user1])
      log_in user1
      expect(page).to have_content("Event Organizers\na\nX\nB\nX")
    end
  end

  def set_up
    user1 = create(:user)
    user2 = create(:user)
    user3 = create(:user)
    event = create(:event, users: [user1, user2])
    log_in user1
    [user1, user3, event]
  end

  def log_in(user)
    stub_people_hub
    stub_cas(user.username)
    sign_in user
    visit dashboard_path
    click_on 'Edit Event'
  end

  def add_organizer(user)
    find('div', id: 'user-event-form').find(:select)
                                      .find(:option, user.username)
                                      .select_option
    click_on 'Add Organizer'
  end

  def remove_organizer(user)
    find('div', id: 'remove-' + user.username).click_on('X')
  end
end
