class UserInvitationEmail < BaseEmail
  to @invitation.inviter!.email
  subject "You've been invited!"
  templates text, html

  def initialize(@invitation : UserInvitation)
  end

  def email : String
    @invitation.inviter!.email
  end
end
