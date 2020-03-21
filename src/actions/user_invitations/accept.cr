class UserInvitations::Accept < BrowserAction
  include Auth::AllowGuests
  post "/user_invitations/:token" do
    invitation = UserInvitationQuery.new.from_token(token).first

    AcceptInvitation.create(params, user_invitation: invitation) do |op, user|
      if op.saved?
        sign_in(user.not_nil!)
        redirect Namespaces::Show.with(user.not_nil!.slug)
      else
        flash.failure = "Need to make sure the form is ok"
        html AcceptPage, operation: op, invitation: invitation
      end
    end
  end
end
