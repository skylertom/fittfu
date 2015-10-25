class Team < ActiveRecord::Base
  validates :name, presence: true
  validates :color, presence: true

  has_many :memberships, dependent: :destroy
  has_many :players, through: :memberships

  has_one :captain_membership, -> { captains }, class_name: 'Membership'
  has_one :captain, class_name: 'Player', through: :captain_membership, source: :player
end
