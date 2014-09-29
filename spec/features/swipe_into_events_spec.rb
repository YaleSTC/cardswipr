require 'spec_helper'

describe "SwipeIntoEvents", :type => :feature do
  before :each do
    app_setup
    # @user = create(:user)
    @event = create(:event)
    sign_in(@event.users.first.netid)
  end

  it "can navigate to the swipe page" do
    visit event_swipe_path(@event)
    # brittle but only unique identifier so far
    expect(page).to have_content 'Card Swipe or NetID or Yale Email'
  end

  it "can swipe someone into the event" do
    visit event_swipe_path(@event)
    fill_in 'query', with: "csw3"
    click_on('Submit')
    save_and_open_page
    expect(page).to have_content 'success'
  end
end

def app_setup
  
end