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

  after_save :create_game_stats

  def create_game_stats
    team.games.each { |game| game.game_stats.create(player_id: player_id) } unless fantasy
  end
end
