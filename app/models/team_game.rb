class TeamGame < ActiveRecord::Base
  validates :game_id, presence: true
  validates :team_id, presence: true
  validates_uniqueness_of :team_id, scope: :game_id

  belongs_to :game
  belongs_to :team
  has_many :game_stats
end
