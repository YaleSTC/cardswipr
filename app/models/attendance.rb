# frozen_string_literal: true

# Model to represent Attendances
# @attr First_name [String] First name of the attendee
# @attr Last_name [String] Last name of the attendee
# @attr Email [String] Email of the attendee
# @attr Net_id [String] net id of the attendee
# @attr Upi [String] upi of the attendee
# @attr Check_in [DateTime] the date/time that the check in happens.
class Attendance < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, format:
  { with: /\A[\w+\-.]+@[a-z\d\-\.]+[^.]\.[a-z]+\z/i }, uniqueness:
    { case_sensitive: false }
  validates :net_id, presence: true
  validates :upi, presence: true
  validates :check_in, presence: true

  # Associations
  belongs_to :event
end
