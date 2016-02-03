class SchedulePolicy < ApplicationPolicy
  attr_reader :user, :schedule

  def initialize(user, schedule)
    @user = user
    @schedule = schedule
  end

  def new?
    user.admin || user.commissioner
  end

  alias_method :create?, :new?
  alias_method :destroy?, :new?
  alias_method :update?, :new?
  alias_method :index?, :new?
  alias_method :edit?, :create?
  alias_method :update, :edit?

end