# frozen_string_literal: true

# Class to represent the many-to-many relationship between User and Event
class UserEvent < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
