class Game < ActiveRecord::Base
  scope :default, -> { order(:week, :time_slot)}
  scope :upcoming, -> { where("time > ?", Time.zone.now) }
  scope :past, -> { where("time < ?", Time.zone.now) }
  # always show this week's
  scope :current, -> { where("time < ? AND time > ?", Time.zone.now.advance(weeks: 1, hours: -2), Time.zone.now.advance(hours: -2)) }

  DURATION = 30

  has_many :team_games, inverse_of: :game, dependent: :destroy
  has_many :teams, through: :team_games
  has_many :players, through: :teams

  validates :time_slot, presence: true
  validates :week, presence: true

  before_create :initialize_time

  def name
    has_teams? ? "#{teams.first.name} VS #{teams.second.name}" : "Not enoughh teams assigned"
  end

  def has_teams?
    return team_games.size == 2
  end

  def initialize_time
    start = Schedule.all.order(:start_time).pluck(:start_time)[week]
    self.time = start.advance(minutes: Game::DURATION * time_slot) if self.time.blank? && !start.blank?
  end
end
