# frozen_string_literal: true

# Policies for Preregistration resources/actions
class PreregistrationPolicy < ApplicationPolicy
  def index?
    user_can_modify_event?(user, record.event)
  end
end
