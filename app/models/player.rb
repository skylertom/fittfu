class Player < ActiveRecord::Base
  GENDER = %w(eman ewo)
  EMAN = 0
  EWO = 1

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
  has_one :membership, -> { real }
  has_one :team, through: :membership
  has_many :games, through: :team
  has_many :game_stats, dependent: :destroy

  validates :name, presence: true

  def gender_text
    GENDER[gender]
  end
end
