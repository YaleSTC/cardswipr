# frozen_string_literal: true

# Model to represent Attendances and Preregistrations
# @attr First_name [String]
# @attr Last_name [String]
# @attr Email [String]
# @attr Net_id [String]
# @attr Upi [String]
# @attr Phone [String] phone number
# @attr Checked_in_at [DateTime] the date/time that the check in happens
class CheckIn < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            format: { with: /\A[\w+\-.]+@[a-z\d\-\.]+[^.]\.[a-z]+\z/i },
            uniqueness: { case_sensitive: false, scope: :event }
  validates :net_id, presence: true
  validates :upi, presence: true
  validates :event, presence: true

  # Associations
  belongs_to :event

  def full_name
    "#{first_name} #{last_name}"
  end
end