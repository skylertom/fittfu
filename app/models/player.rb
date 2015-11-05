class Player < ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships

  validates :name, presence: true
end
