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

  def num_wins
    team_games.won.size
  end

  def rank
    # TODO much more efficiently
    mywins = num_wins
    wins = Team.all.map {|t| t.num_wins}
    wins.sort {|a, b| b <=> a}.each_with_index {|t, i| return i+1 if t <= mywins}
  end

  def num_losses
    team_games.lost.size
  end

  def record_text
    "#{num_wins}-#{num_losses}"
  end
end
