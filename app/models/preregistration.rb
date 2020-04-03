# frozen_string_literal: true

# Model to represent Pregistration
# @attr First_name [String] First name of the preregistered attendee
# @attr Last_name [String] Last name of the preregistered attendee
# @attr Email [String] Email of the preregistered attendee
# @attr Net_id [String] net id of the preregistered attendee
# @attr Upi [String] upi of the preregistered attendee
# @attr Phone [String] phone number of the preregistered attendee
# @attr Checked_in [Boolean] whether the preregistered attendee has checked in
class Preregistration < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-\.]+[^.]\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false, scope: :event }
  validates :net_id, presence: true
  validates :upi, presence: true
  validates :checked_in, presence: true

  # Associations
  belongs_to :event
end
