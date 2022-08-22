# frozen_string_literal: true

class AccountPolicy < ApplicationPolicy

  def update?
    account == resource
  end

  def edit?
    account == resource
  end

  def destroy?
    account == resource
  end
end
