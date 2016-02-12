class GameStat < ActiveRecord::Base
  FIELDS = %w(Ds Goals Assists Turns Swag)

  belongs_to :player
  belongs_to :team_game
  has_one :team, through: :player
  has_one :game, through: :team_game

  validates :team_game_id, presence: true
  validates :player_id, presence: true, uniqueness: { scope: :team_game_id }

  before_update :update_points
  before_destroy :remove_points

  TYPE = %i(goals assists ds turns swag)
  SCORE = [3, 3, 2, -1, 1]

  COUNT = TYPE.zip(SCORE)

  def update_points
    team_game.update_attributes(goals: team_game.goals + (goals - goals_was)) if goals_changed?
    prior_points = self[:points]
    self[:points] = COUNT.inject(0) { |sum, obj| sum + self[obj[0]] * obj[1] }
    player.update_attribute(:points, player.points + points - prior_points)
  end

  def remove_points
    player.update_attribute(:points, player.points - points) unless player.blank?
  end
end
