# frozen_string_literal: true

# Class for CardSwipr users (event admins)
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :cas_authenticatable

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  enum role: %w(user superuser)

  # @return [String] First name plus last name
  def full_name
    "#{first_name} #{last_name}"
  end
end
