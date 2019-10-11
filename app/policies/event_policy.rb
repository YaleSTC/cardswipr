# frozen_string_literal: true

# Policies for Event resources/actions
class EventPolicy < ApplicationPolicy
  def create?
    true
  end

  def new?
    create?
  end

  def show?
    user_can_modify_event?(user, record)
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
