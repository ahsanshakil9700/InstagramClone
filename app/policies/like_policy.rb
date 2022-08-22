# frozen_string_literal: true

class LikePolicy < ApplicationPolicy

  def create?
    resource.account == account
  end

  def destroy?
    resource.account == account
  end
end
