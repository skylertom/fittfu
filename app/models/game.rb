class Game < ActiveRecord::Base
  validates :time_slot, presence: true
  validates :week, presence: true #should validate these are unique

  has_many :team_games
  has_many :teams, through: :team_games
  has_many :game_stats, through: :team_games
end
