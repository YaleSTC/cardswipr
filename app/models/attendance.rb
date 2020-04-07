# frozen_string_literal: true

# Model to represent Attendances
# @attr First_name [String] First name of the attendee
# @attr Last_name [String] Last name of the attendee
# @attr Email [String] Email of the attendee
# @attr Net_id [String] net id of the attendee
# @attr Upi [String] upi of the attendee
# @attr Phone [String] phone number of the attendee
# @attr Checked_in_at [DateTime] the date/time that the check in happens
class Attendance < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-\.]+[^.]\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false, scope: :event }
  validates :net_id, presence: true
  validates :upi, presence: true
  validates :checked_in_at, presence: true
  validates :event, presence: true

  # Associations
  belongs_to :event

  def full_name
    "#{first_name} #{last_name}"
  end
end
