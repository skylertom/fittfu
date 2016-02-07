class Invitation < ActiveRecord::Base
  TYPES = %w(admin commissioner)

  belongs_to :user
  belongs_to :invitor, class_name: 'User'

  validates :invitor_id, presence: true
  validates :email, presence: true
  validates :code, presence: true
  validates :authority, presence: true, inclusion: { in: TYPES }

  def self.find_valid(code)
    code.blank? ? nil : Invitation.find_by(code: code, accepted: 0)
  end
end
