class InvitationPolicy < ApplicationPolicy
  attr_reader :user, :invitation

  def initialize(user, invitation)
    @user = user
    @invitation = invitation
  end

  def permitted_attributes
    [:authority, :code, :invited_by, :email]
  end

  def new?
    user.admin || user.commissioner
  end

  def index?
    user.admin
  end

  def destroy?
    user.admin
  end

  alias_method :create?, :new?
  alias_method :update?, :destroy?
end