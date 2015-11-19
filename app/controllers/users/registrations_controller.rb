class Users::RegistrationsController < Devise::RegistrationsController
  def new
    super do
      unless params['invite'].blank?
        invite = Invitation.find_by(code: params['invite'], accepted: 0, user_id: nil)
        if invite.blank?
          flash[:error] = "Invite link is not valid"
        else
          flash[:success] = "Please sign up to become a(n) #{invite.authority}"
          resource.invite_code = invite.code
        end
      end
    end
  end
end
