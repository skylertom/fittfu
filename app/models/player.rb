class Player < ActiveRecord::Base
  validates :name, presence: true

  has_many :memberships, dependent: :destroy
  has_many :teams, through: :memberships
end
