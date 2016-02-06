class GameStat < ActiveRecord::Base
  FIELDS = %w(Ds Goals Assists Turns Swag)

  belongs_to :player
  belongs_to :game
  has_one :team, through: :player

  validates :game_id, presence: true
  validates :player_id, presence: true, uniqueness: { scope: :game_id }

  before_save :update_team_game, if: :goals_changed?

  TYPE = %i(goals assists ds turns swag)
  SCORE = [3, 3, 2, -1, 1]
  COUNT = TYPE.zip(SCORE)


  def points
    COUNT.inject(0) { |sum, obj| sum + self[obj[0]] * obj[1] }
  end

  def update_team_game
    team.team_games.find_by(team_id: team.id).update_attributes(points: goals - goals_was)
  end
end
