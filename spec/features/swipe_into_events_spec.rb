require 'spec_helper'

describe "SwipeIntoEvents", :type => :feature do
  before :each do
    app_setup
    @user = create(:user)
    sign_in(@user.login)
  end

  it "can navigate to the swipe page" do
    visit event_swipe_path(@event)
    save_and_open_page

    # brittle but only unique identifier so far
    expect(page).to have_content 'Card Swipe or NetID or Yale Email'
  end

  xit "can swipe someone into the event" do
    visit event_swipe_path(@event)
  end
end

def app_setup
  
end