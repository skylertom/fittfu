class GameStatPolicy < ApplicationPolicy
  attr_reader :user, :game_stat

  def initialize(user, game_stat)
    @user = user
    @game_stat = game_stat
  end

  def update?
    user.admin || user.commissioner
  end
end