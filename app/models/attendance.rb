# frozen_string_literal: true

# Model to represent Attendances
class Attendance < CheckIn
  validates :checked_in_at, presence: true
end
