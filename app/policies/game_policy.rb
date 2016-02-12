class GamePolicy < ApplicationPolicy
  attr_reader :user, :game

  def initialize(user, game)
    @user = user
    @game = game
  end

  def permitted_attributes
    [:week, :time_slot]
  end

  def index?
    !user.blank?
  end

  def new?
    user.admin || user.commissioner
  end

  def scorekeep?
    user.admin || user.commissioner
  end

  def create_schedule?
    user.admin
  end

  def destroy?
    user.admin || user.commissioner
  end

  def delete_all?
    user.admin
  end

  alias_method :create?, :new?
  alias_method :new_week?, :new?
  alias_method :create_week?, :create?
  alias_method :edit?, :create?
  alias_method :update?, :edit?
  alias_method :show?, :index?
end