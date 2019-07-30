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
      true
    end
  rescue ActiveRecord::RecordInvalid, RuntimeError
    false
  end

  def create_attendance(search_param)
    person = look_up(search_param)
    @event.attendances.create!(
      first_name: person.first_name, last_name: person.last_name,
      email: person.email, net_id: person.net_id, upi: person.upi,
      phone: person.phone, checked_in_at: Time.zone.now
    )
  end

  def look_up(search_param)
    key = determine_key(search_param)
    PeopleHub::PersonRequest.get(key => search_param)
  end

  # Returns the type of the search param, either prox number or netid
  #
  # @param [String]
  # @return [Symbol] the type of the search param
  def determine_key(search_param)
    if search_param.length == 10 && search_param.match?(/^[0-9]{10}$/)
      :proxnumber
    elsif search_param.match?(/^[a-z]{1,5}[0-9]{1,5}$/)
      :netid
    else
      :invalid_param
    end
  end
end
