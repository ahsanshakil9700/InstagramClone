# frozen_string_literal: true

class PostPolicy < ApplicationPolicy

  def create?
    resource.account == account
  end

  def edit?
    resource.account == account
  end

  def destroy?
    resource.account == account
  end

  def update?
    resource.account == account
  end
end
