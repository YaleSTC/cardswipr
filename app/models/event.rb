# frozen_string_literal: true

# Class for Cardswipr events
# @attr Title [String] Title of the event being made.
# @attr Description [String] Describes the event being made
class Event < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }

  before_validation :remove_whitespaces

  # Associations
  has_many :attendances, dependent: :destroy
  has_many :user_events, dependent: :destroy
  has_many :users, through: :user_events
  has_many :preregistrations, dependent: :destroy
  has_many :check_ins, dependent: :destroy

  private

  def remove_whitespaces
    title.strip! if title.present?
    description.strip! if description.present?
  end
end
