class Membership < ActiveRecord::Base
  validates :player_id, presence: true
  validates :team_id, presence: true
  validates_uniqueness_of :player_id, scope: :team_id
  validates :role, inclusion: Team::Role::ROLES

  belongs_to :player
  belongs_to :team

  scope :for, ->(team) { where(team: team) }
  scope :non_captains, -> { where(role: Team::Role::PLAYER) }
  scope :captains, -> { where(role: Team::Role::CAPTAIN) }
  scope :captain, -> { where(role: Team::Role::CAPTAIN).first }
end
