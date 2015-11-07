class Team < ActiveRecord::Base
  STD_SIZE = 8
  GAMES_IN_NIGHT = 4

  has_many :memberships, dependent: :destroy
  has_many :players, through: :memberships
  has_one :captain_membership, -> { captains }, class_name: 'Membership'
  has_one :captain, class_name: 'Player', through: :captain_membership, source: :player
  has_many :team_games
  has_many :games, through: :team_games, dependent: :destroy

  validates :name, presence: true
  validates :color, presence: true
end
