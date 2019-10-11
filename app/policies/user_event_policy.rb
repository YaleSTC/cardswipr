# frozen_string_literal: true

# Policies for UserEvent resources/actions
class UserEventPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    user_can_modify_event?(user, record.event)
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
