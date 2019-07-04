# frozen_string_literal: true

# Class for CardSwipr users (event admins)
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :cas_authenticatable

  # Associations
  has_many :user_events, dependent: :destroy
  has_many :events, through: :user_events

  def cas_extra_attributes=(_extra_attributes)
    person = PeopleHub::PersonRequest.get(netid: username)
    self.email = person.email
  end
end
