# frozen_string_literal: true

# Class to represent the many-to-many relationship between User and Event
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
  accepts_nested_attributes_for :user

  validates :user, presence: true,
                   uniqueness:
                   { scope: :event_id,
                     message: 'is already an organizer on this event' }
  validates :event, presence: true
end
