# frozen_string_literal: true

# Policies for Attendance resources/actions
class AttendancePolicy < ApplicationPolicy
  def create?
    true
  end

  def index?
    user_can_modify_event?(user, record.event)
  end

  def destroy?
    index?
  end

  def export?
    index?
  end
end
