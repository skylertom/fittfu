class GameStat < ActiveRecord::Base
  FIELDS = %w(Ds Goals Assists Turns)

  belongs_to :player
  belongs_to :team_game
  has_one :team, through: :team_game
  has_one :game, through: :team_game

  validates :team_game_id, presence: true
  validates :player_id, presence: true, uniqueness: { scope: :team_game_id }

  TYPE = %i(goals assists ds turns)
  SCORE = [2, 2, 2, -1]
  COUNT = TYPE.zip(SCORE)


  def points
    COUNT.inject(0) { |sum, obj| sum + self[obj[0]] * obj[1] }
  end
end
