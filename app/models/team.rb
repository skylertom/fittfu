class Team < ActiveRecord::Base
  scope :real, -> { where(fantasy: false) }
  scope :for_fantasy, -> { where(fantasy: true) }

  STD_SIZE = 8

  has_many :memberships, dependent: :destroy
  has_many :players, through: :memberships
  has_one :captain_membership, -> { captains }, class_name: 'Membership'
  has_one :captain, through: :captain_membership, source: :player
  has_many :team_games, dependent: :destroy
  has_many :games, through: :team_games, dependent: :destroy

  validates :name, presence: true
  validates :color, presence: true

  before_create :before_create

  #for lookup in google spreadsheet
  def before_create
    self.captain_tab = self.name if self.captain_tab.blank?
    self.short_name = self.name if self.short_name.blank?
  end
end
