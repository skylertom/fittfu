class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  GUEST_ID = "2fa8c788-1dec-4500-9721-95253f6a9322"
  TUFTS_REGEX = /\b[A-Z0-9._%a-z\-]+@tufts.edu/

  has_many :sent_invites, class_name: 'Invitation', foreign_key: 'invitor_id'
  has_many :used_invites, class_name: 'Invitation', foreign_key: 'user_id', dependent: :destroy

  validates :email, presence: true
  validates :name, presence: true
  validates :email, format: { with: TUFTS_REGEX, message: "must be a Tufts email or have an invitation" },
            on: :create,
            unless: Proc.new { |u| !Invitation.find_valid(u.invite_code).blank? }

  before_validation { self.email.downcase! unless self.email.blank? }
  after_create :resolve_invitations

  def resolve_invitations
    i = Invitation.find_valid(invite_code)
    unless i.blank?
      self.update(i.authority => true)
      i.update(user_id: id, accepted: 1)
    end
  end
end