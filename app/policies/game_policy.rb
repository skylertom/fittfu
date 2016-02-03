class GamePolicy < ApplicationPolicy
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end

  def permitted_attributes
    [:week, :time_slot]
  end

  def new?
    user.admin
  end

  def scorekeep?
    user.admin || user.commissioner
  end

  def create_schedule?
    user.admin
  end

  def destroy?
    user.admin
  end

  def delete_all?
    user.admin
  end

  alias_method :create?, :new?
  alias_method :edit?, :create?
  alias_method :update?, :edit?
end