class UserInvitations::Show < BrowserAction
  include Auth::AllowGuests
  get "/user_invitations/:token" do
    user_invitation = UserInvitationQuery.new.from_token(token).first?

    if user_invitation && user_invitation.accepted?
      flash.info = "You've already accepted this invitation, please sign in."
      redirect SignIns::New
    elsif user_invitation && !user_invitation.accepted?
      html AcceptPage, operation: AcceptInvitation.new(user_invitation), invitation: user_invitation
    else
      flash.failure = "This invitation does not exist or is expired"
      redirect Home::Index
    end
  end
end
