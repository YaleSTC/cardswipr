require 'spec_helper'

RSpec.describe AttendanceEntry, type: :model do

  before :each do
    @event = create(:event)
    @upi = "12714662" #Casey Watts' UPI
  end

  it "can be created" do
    attendance_entry = AttendanceEntry.create(upi: @upi, event: @event)
    expect(attendance_entry.first_name).to eq 'Casey'
  end

end
