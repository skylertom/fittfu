class Schedule < ActiveRecord::Base
  default_scope { order('start_time ASC') }
  scope :for, ->(year) { where(year: year) }

  VALID_STARTS = %w(5:00pm 5:30pm 6:00pm 6:30pm 7:00pm 7:30pm 8:00pm 8:30pm 9:00pm 9:30pm 10:00pm 10:30pm)
  GAMES_IN_NIGHT = 4
  LENGTH = 30

  validates :start_time, presence: true
  validates :end_time, presence: true
  validate :end_time_is_later

  after_validation :assign_year

  def assign_year
    self.year = start_time.year
  end

  def end_time_is_later
    errors.add(:end_time, "must be later than start time") if !start_time.blank? && !end_time.blank? && start_time > end_time
  end
end
