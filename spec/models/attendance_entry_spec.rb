require 'spec_helper'

RSpec.describe AttendanceEntry, type: :model do

  before :each do
    @event = create(:event)
    @upi = '2'
  end

  it "can be created" do
    attendance_entry = AttendanceEntry.create(upi: @upi, event: @event)
    expect(attendance_entry.first_name).to eq 'Frodo'
  end
 
end
