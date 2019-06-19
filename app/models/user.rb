# frozen_string_literal: true

# Class for CardSwipr users (event admins)
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :cas_authenticatable

  validates :first_name, presence: true
  validates :last_name, presence: true

  # Associations
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  def cas_extra_attributes=(_extra_attributes)
    return unless email.empty?

    person = PeopleHub::PersonRequest.get(netid: username)
    self.email = person.email
    self.first_name = person.first_name
    self.last_name = person.last_name
  end
end
