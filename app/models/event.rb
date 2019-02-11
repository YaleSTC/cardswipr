# frozen_string_literal: true

# Class for Cardswipr events
class Event < ApplicationRecord
  has_many :attendances, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }

  before_validation :remove_whitespaces

  private

  def remove_whitespaces
    title.strip! if title.present?
    description.strip! if description.present?
  end
end
