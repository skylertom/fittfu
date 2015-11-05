class Membership < ActiveRecord::Base
  scope :for, ->(team) { where(team: team) }
  scope :non_captains, -> { where(captain: true) }
  scope :captains, -> { where(captain: true) }

  belongs_to :player
  belongs_to :team

  validates :player_id, presence: true
  validates :team_id, presence: true, uniqueness: { scope: :team_id }
end
