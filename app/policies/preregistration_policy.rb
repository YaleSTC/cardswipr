# frozen_string_literal: true

# Policies for Preregistration resources/actions
class PreregistrationPolicy < ApplicationPolicy
  def create?
    index?
  end

  def index?
    user_can_modify_event?(user, record.event) && record.event.preregistration
  end

  def destroy?
    index?
  end

  def import?
    index?
  end
end
