class Membership < ActiveRecord::Base
  scope :real, -> { where(fantasy: false) }
  scope :for_fantasy, -> { where(fantasy: true) }
  scope :for, ->(team) { where(team: team) }
  scope :non_captains, -> { where(captain: false) }
  scope :captains, -> { where(captain: true) }

  belongs_to :player
  belongs_to :team

  validates :player_id, presence: true
  validates :team_id, presence: true, uniqueness: { scope: :player_id }

  after_create :create_game_stats
  after_destroy :remove_game_stats

  def create_game_stats
    unless self.fantasy
      team_game_ids = team.team_games.pluck(:id)
      team_game_ids.each { |team_game_id| GameStat.create(player_id: player_id, team_game_id: team_game_id) }
    end
  end

  def remove_game_stats
    team_games = TeamGame.where(team_id: team_id).pluck(:id)
    GameStat.where(player_id: player_id, team_game_id: team_games).destroy_all
  end
end
