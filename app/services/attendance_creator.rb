# frozen_string_literal: true

# Service object to create an Attendance
class AttendanceCreator
  attr_accessor :attendance
  # Initialize an AttendanceCreator
  #
  # @param event [Event]
  # @param search_param [String]
  def initialize(event:, search_param:)
    @event = event
    @search_param = search_param
  end

  def call
    ActiveRecord::Base.transaction do
      @attendance = create_attendance(@search_param)
      @event.update!(updated_at: Time.zone.now)
      true
    end
  rescue ActiveRecord::RecordInvalid, RuntimeError
    false
  end

  def create_attendance(search_param)
    person = PeopleHub::PersonRequest.get(
      PeopleHub::ParamsParser.create_search_hash(search_param)
    )
    @event.attendances.create!(
      first_name: person.first_name, last_name: person.last_name,
      email: person.email, net_id: person.net_id, upi: person.upi,
      phone: person.phone, checked_in_at: Time.zone.now
    )
  end
end
