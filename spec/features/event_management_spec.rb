require 'spec_helper'

describe "EventManagement", :type => :feature do
  before :each do
    @event = create(:event)
    sign_in(@event.users.first.netid)
  end

  it "can create a new event" do
    visit new_event_path
    #fill out the form
    #submit
    #make sure we have a new event made
  end
  xit "can view the attendance list for an event" do
    visit event_path(@event)
    #make sure it is the event page
  end
  xit "can edit an existing event" do
    visit edit_event_path(@event)
    #form
    #submit
    #make sure it is edited
  end
  xit "can destroy an event" do
    visit destroy_event_path(@event)
    #make sure it is destroyed
  end
end
