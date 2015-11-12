class Game < ActiveRecord::Base
  default_scope { order(:week, :time_slot)}

  has_many :team_games, dependent: :destroy
  has_many :teams, through: :team_games
  has_many :players, through: :teams
  has_many :game_stats, dependent: :destroy

  validates :time_slot, presence: true, uniqueness: { scope: :week }
  validates :week, presence: true

  def name
    teams.any? ? "#{teams.first.name} vs #{teams.second.name}" : "No teams assigned"
  end

  def create_game_stats
    players.pluck(:id).each do |player_id|
      self.game_stats.create(player_id: player_id)
    end
  end
end
