# frozen_string_literal: true

# Policies for Event resources/actions
class EventPolicy < ApplicationPolicy
  attr_reader :user, :event

  def initialize(user, event)
    raise Pundit::NotAuthorizedError, 'must be logged in' unless user

    @user = user
    @event = event
    @user_event = UserEvent.find_by(user: @user.id, event: @event.id)
  end

  def create?
    true
  end

  def show?
    @user_event.present?
  end

  def update?
    @user_event.present?
  end

  def destroy?
    @user_event.present?
  end
end
