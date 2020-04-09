# frozen_string_literal: true

# Policies for Preregistration resources/actions
class PreregistrationPolicy < ApplicationPolicy
  def create?
    true
  end

  def index?
    true
  end

  def destroy?
    index?
  end
end
