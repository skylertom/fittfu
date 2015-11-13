class Game < ActiveRecord::Base
  default_scope { order(:week, :time_slot)}
  #scope :upcoming, -> { where("time > ?", Time.zone.now) }
  #scope :past, -> { where("time < ?", Time.zone.now) }
  # always show this week's
  #scope :current, -> { where("time < ? AND time > ?", Time.zone.now.advance(weeks: 1, hours: -2, minutes: 5), Time.zone.now.advance(hours: -2, minutes: 5)) }

  DURATION = 30

  has_many :team_games, inverse_of: :game, dependent: :destroy
  has_many :teams, through: :team_games
  has_many :players, through: :teams
  has_many :game_stats, dependent: :destroy

  validates :time_slot, presence: true, uniqueness: { scope: :week }
  validates :week, presence: true

  def name
    has_teams? ? "#{teams.first.name} vs #{teams.second.name}" : "Not enoughh teams assigned"
  end

  def has_teams?
    return team_games.size == 2
  end
end
