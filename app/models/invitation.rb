class Invitation < ActiveRecord::Base
  TYPES = %w(admin commissioner)

  belongs_to :user
  belongs_to :invitor, class_name: 'User'

  validates :invitor_id, presence: true
  validates :email, presence: true
  validates :authority, presence: true, inclusion: { in: TYPES }
end
