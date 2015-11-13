class Schedule < ActiveRecord::Base
  default_scope { order('start_time ASC') }
  scope :for, ->(year) { where(year: year) }

  VALID_STARTS = %w(5:00pm 5:30pm 6:00pm 6:30pm 7:00pm 7:30pm 8:00pm 8:30pm 9:00pm 9:30pm 10:00pm 10:30pm)
  GAMES_IN_NIGHT = 4

  validates :start_time, presence: true
  validates :end_time, presence: true

  after_validation :assign_year

  def assign_year
    self.year = start_time.year
  end
end
