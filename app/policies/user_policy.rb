class UserPolicy < ApplicationPolicy
  def update?
    user.id != User.GUEST_ID
  end

  def index?
    user.admin
  end

  alias_method :destroy?, :index?
end