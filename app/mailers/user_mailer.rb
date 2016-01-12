class UserMailer < ApplicationMailer
  def invite_email(invite)
    @invite = invite
    @invitor = invite.invitor
    mail(to: @invite.email, subject: "Join FITTFU as a(n) #{@invite.authority}")
  end
end
