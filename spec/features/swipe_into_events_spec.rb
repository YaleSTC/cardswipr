require 'rails_helper'

feature "SwipeIntoEvents", :type => :feature do
  before :each do
    app_setup
    @user = create(:admin)
    sign_in(@user.login)
  end

  xit "can navigate to the swipe page" do
    visit event_swipe_path(@event)
  end

  xit "can swipe someone into the event" do
    visit event_swipe_path(@event)
  end
end

def app_setup
  
end