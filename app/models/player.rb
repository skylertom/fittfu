class Player < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_one :membership, -> { real }
  has_one :team, through: :membership
  has_many :game_stats, dependent: :destroy


  validates :name, presence: true
end
