class PlayerPolicy < ApplicationPolicy
  attr_reader :user, :player

  def initialize(user, player)
    @user = user
    @player = player
  end

  def permitted_attributes
    [:name, :gender]
  end

  def new?
    user.admin || user.commissioner
  end

  alias_method :create?, :new?
  alias_method :destroy?, :new?
  alias_method :update?, :create?

end