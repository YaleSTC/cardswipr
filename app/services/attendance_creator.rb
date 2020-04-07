# frozen_string_literal: true

# Service object to create an Attendance
class AttendanceCreator
  include ActiveModel::Model
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
  rescue StandardError, ActiveRecord::RecordInvalid
    errors.add(:base, 'Check-in failed')
    false
  end

  private

  def create_attendance(search_param)
    person = PeopleHub::PersonRequest.get(search_param)
    check_preregistrations(person) if @event.preregistration
    @event.attendances.create!(
      first_name: person.first_name, last_name: person.last_name,
      email: person.email, net_id: person.net_id, upi: person.upi,
      phone: person.phone, checked_in_at: Time.zone.now
    )
  end

  # checks if person has preregistered for event
  # raises exception if person has not preregistered
  def check_preregistrations(person)
    prereg = @event.preregistrations.find_by(net_id: person.net_id)
    unless prereg
      errors.add(:base, 'This person has not preregistered')
      raise StandardError, 'No preregistration found'
    end
    prereg.update(checked_in: true)
  end
end
