class Membership < ActiveRecord::Base
  validates :player_id, presence: true
  validates :team_id, presence: true
  validates_uniqueness_of :player_id, scope: :team_id

  belongs_to :player
  belongs_to :team

  scope :for, ->(team) { where(team: team) }
  scope :non_captains, -> { where(captain: true) }
  scope :captains, -> { where(captain: true) }
end
