class CommentPolicy < ApplicationPolicy

  def create?
    resource.account == account
  end

  def destroy?
    resource.account == account
  end
end
