class TeamGame < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  has_many :game_stats, dependent: :destroy

  validates :game_id, presence: true
  validates :team_id, presence: true, uniqueness: { scope: :game_id }

  after_create :create_game_stats

  def create_game_stats
    team.players.find_each do |player|
      player.game_stats.create(team_game_id: self.id)
    end
  end
end
