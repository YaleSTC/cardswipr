require 'spec_helper'

RSpec.describe Event, type: :model do
  it '#last_edited works' do
    event = Event.create
    expect(event.last_edited).to eq('')
    entry = create(:attendance_entry, event: event)
    event.attendance_entries << entry
    expect(event.last_edited).to eq(entry.swipe_time)
  end
end
