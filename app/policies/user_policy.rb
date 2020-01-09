# frozen_string_literal: true

# Policies for User resources/actions
class UserPolicy < ApplicationPolicy
  def show?
    user.superuser? || (user == record)
  end

  def create?
    show?
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

  def superuser_dash?
    user.superuser?
  end
end
