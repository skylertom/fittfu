class TeamGame < ActiveRecord::Base
  belongs_to :game
  belongs_to :team

  validates :game_id, presence: true
  validates :team_id, presence: true, uniqueness: { scope: :game_id }
end
