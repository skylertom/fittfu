class GameStat < ActiveRecord::Base
  FIELDS = %w(Ds Goals Assists Turns)

  belongs_to :player
  belongs_to :team_game

  validates :team_game_id, presence: true
  validates :player_id, presence: true, uniqueness: { scope: :team_game_id }
end
