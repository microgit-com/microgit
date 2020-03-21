class InviteUser < UserInvitation::SaveOperation
  permit_columns invitee_email

  after_commit :send_invite_email

  before_save do
    sent_at.value = Time.utc
    token.value = Random::Secure.hex(32)
  end

  def send_invite_email(user_invitation)
    UserInvitationEmail.new(user_invitation).deliver_later
  end
end
