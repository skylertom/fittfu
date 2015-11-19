class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :resolve_invitations

  def resolve_invitations
    i = Invitation.find_by(code: invite_code, user_id: nil, accepted: 0)
    unless i.blank? || i.invitor.blank?
      self.update(i.authority => true)
      i.update(user_id: id, accepted: 1)
    end
  end
end