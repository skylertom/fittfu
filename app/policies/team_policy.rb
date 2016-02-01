class TeamPolicy < ApplicationPolicy
  attr_reader :user, :team

  def initialize(user, team)
    @user = user
    @team = team
  end

  def new?
    user.admin || user.commissioner
  end

  alias_method :create?, :new?
  alias_method :destroy?, :new?
  alias_method :update?, :create?
end