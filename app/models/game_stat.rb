class GameStat < ActiveRecord::Base
  validates :team_game_id, presence: true
  validates :player_id, presence: true
  validates_uniqueness_of :player_id, scope: :team_game_id

  belongs_to :player
  belongs_to :team_game
end
