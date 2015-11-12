class TeamGame < ActiveRecord::Base
  belongs_to :game, inverse_of: :team_games
  belongs_to :team

  validates :game_id, presence: true
  validates :team_id, presence: true, uniqueness: { scope: :game_id }

  after_save :create_game_stats
  before_destroy :destroy_game_stats

  def create_game_stats
    team.players.pluck(:id).each do |player_id|
      self.game.game_stats.create(player_id: player_id)
    end
  end

  def destroy_game_stats
    game.game_stats.where(player_id: team.players.pluck(:id)).destroy_all
  end
end
