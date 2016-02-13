class TeamGame < ActiveRecord::Base
  scope :won, -> { where(winner: true)}
  scope :lost, -> { where(winner: false)}

  belongs_to :game, inverse_of: :team_games
  belongs_to :team
  has_many :game_stats, dependent: :destroy

  validates :game_id, presence: true
  validates :team_id, presence: true, uniqueness: { scope: :game_id }

  after_save :create_game_stats

  def create_game_stats
    team.players.pluck(:id).each do |player_id|
      self.game_stats.create(player_id: player_id, week: self.game.week)
    end
  end

  def opponent_team_game
    game.team_games.where.not(id: id).first
  end

  def result_text
    if game.time > Time.zone.now
      "Undecided"
    else
      winner? ? "Lost (#{goals}-#{opponent_team_game.goals})" : "Won (#{goals}-#{opponent_team_game.goals})"
    end
  end
end
