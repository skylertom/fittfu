class Game < ActiveRecord::Base
  has_many :team_games, dependent: :destroy
  has_many :teams, through: :team_games
  has_many :game_stats, through: :team_games

  # TODO should validate these are unique
  validates :time_slot, presence: true, uniqueness: { scope: :week }
  validates :week, presence: true
end
