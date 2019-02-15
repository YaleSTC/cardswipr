# frozen_string_literal: true

# Class to represent the many-to-many relationship between Events and
#   Attendances
class EventAttendance < ApplicationRecord
  belongs_to :event
  belongs_to :attendance
end
